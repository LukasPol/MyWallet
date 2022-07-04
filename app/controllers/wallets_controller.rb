class WalletsController < ApplicationController
  before_action :set_wallet

  def index
    @search = current_user.tradings.ransack(params[:q])
    @tradings = @search.result.includes(:stock)
    @grouped_tradings = group_tradings
  end

  private

  def set_wallet
    @wallet = current_user.main_wallet
  end

  def group_tradings
    stocks_ids = @tradings.collect(&:stock_id).uniq
    stocks_ids.map do |id|
      tradings = @wallet.tradings.where(stock_id: id, kind: :buy)
      average_price = calculate_average_price(tradings)
      {
        average_price: average_price,
        stock: Stock.find(id).code,
        stock_id: id,
        amount: tradings.sum(&:amount)
      }
    end
  end

  def calculate_average_price(tradings)
    price = tradings.map do |t|
      t.amount * t.value
    end.sum

    amount_total = tradings.sum(&:amount)

    price / amount_total
  rescue ZeroDivisionError
    0
  end
end
