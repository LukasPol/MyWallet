class Stock
  class InformationCollectorWorker
    include Sidekiq::Worker
    include Sidekiq::Job

    sidekiq_options queue: :instant_messages, retry: 4

    def perform
      Rails.logger.info('Stock::InformationCollectorWorker')

      Stock.all.each do |stock|
        Rails.logger.info("\n === Get information: #{stock} === ")
        Stock::InformationCollector.call(stock)
        sleep rand(5..12)
      end
    end
  end
end
