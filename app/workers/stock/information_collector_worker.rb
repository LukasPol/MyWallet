class Stock
  class InformationCollectorWorker
    include Sidekiq::Worker
    include Sidekiq::Job

    sidekiq_options queue: :instant_messages, retry: 4

    def perform
      if Time.zone.now.on_weekend? || stocks_exchange_closed?
        Rails.logger.info('Stock Exchange Closed')
        return
      end

      Rails.logger.info('Stock::InformationCollectorWorker')

      Stock.all.each do |stock|
        Rails.logger.info("=== Get information: #{stock} ===")
        Stock::InformationCollector.call(stock)
        sleep rand(5..10)
      end
    end

    def stocks_exchange_closed?
      time_now = Time.zone.now
      open = Time.zone.parse('10:00:00')
      close = Time.zone.parse('18:00:00')

      (open > time_now) || (close < time_now)
    end
  end
end
