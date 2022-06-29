namespace :stocks do
  desc 'Information Collector of Stocks'
  task information_collector: :environment do
    Stock::InformationCollectorWorker.perform_async
  end
end
