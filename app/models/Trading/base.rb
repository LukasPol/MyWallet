class Trading
  class Base
    prepend SimpleCommand

    def initialize(params, trading = nil)
      @trading = trading
      @date = "#{params["date(1i)"]}-#{params["date(2i)"]}-#{params["date(3i)"]}"
      @value = params[:value]
      @amount = params[:amount]
      @kind = params[:kind]
      @user = params[:user]
      @wallet = @user.main_wallet
      @stock = Stock.find_or_create_by(code: params[:stock])
    end

    def attributes
      { date: @date, value: @value, amount: @amount, kind: @kind, user: @user, wallet: @wallet, stock: @stock }
    end
  end
end
