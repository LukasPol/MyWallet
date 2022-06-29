require 'open-uri'
require 'nokogiri'

class Stock
  class InformationCollector
    prepend SimpleCommand

    attr_reader :code, :stock, :template

    def initialize(stock)
      @code = stock.code
      @stock = stock
      @template = parsed_template
    end

    def call
      return if template.nil?

      set_price

      set_company_name_and_document if stock.company_name.nil? || stock.document.nil?
      set_name if stock.name.nil?
      stock.save!
    end

    private

    def parsed_template
      Nokogiri::HTML(URI.open("https://statusinvest.com.br/acoes/#{code}"), nil, Encoding::UTF_8.to_s)
    rescue OpenURI::HTTPError
      stock.update(has_problem: true)
      Rails.logger.error "Problems with the Stock #{code}"
      nil
    end

    def set_price
      price = template.xpath('//div[@title="Valor atual do ativo"]//strong[@class="value"]').text.gsub(',', '.')
      stock.price = price
    end

    def set_company_name_and_document
      information =  template.css('div.company-description > h4').text.split("\n")

      company_name = information[1]
      document = information.last
      stock.company_name = company_name
      stock.document = document
    end

    def set_name
      name = template.xpath('//h1[starts-with(@title, "PETR4")]').text.split(' - ').last
      stock.name = name
    end
  end
end
