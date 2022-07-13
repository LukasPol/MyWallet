class Asset
  class Updater
    prepend SimpleCommand

    attr_accessor :trading, :asset

    def initialize(trading)
      @trading = trading
      @asset = Asset.find_or_create_by(stock: trading.stock, user: trading.user, wallet: trading.wallet)
    end

    def call
      return if trading.invalid?

      if trading.kind == 'buy'
        calculate_buy
      else
        calculate_hold
      end

      update_asset

      trading.valid?
    end

    private

    def update_asset
      asset.save
      trading.asset = asset
    end

    def calculate_buy
      asset.amount += trading.amount
      asset.total_invested += trading.total_value

      asset.average_price = asset.total_invested / asset.amount
    end

    def calculate_hold
      asset.amount -= trading.amount

      if asset.amount.zero?
        asset.average_price = 0
        asset.total_invested = 0
      else
        asset.total_invested = asset.average_price * asset.amount
      end
    end
  end
end
