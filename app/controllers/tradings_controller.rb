class TradingsController < ApplicationController
  before_action :set_trading, only: %i[show edit update destroy]

  # GET /tradings
  def index
    @tradings = current_user.tradings
  end

  # GET /tradings/1
  def show; end

  # GET /tradings/new
  def new
    @trading = Trading.new
  end

  # GET /tradings/1/edit
  def edit; end

  # POST /tradings
  def create
    @trading = Trading.new(trading_params)

    if @trading.save
      redirect_to tradings_url, notice: t(:created_f, model: t(:trading, scope: 'activerecord.models'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tradings/1
  def update
    if @trading.update(trading_params)
      redirect_to tradings_url, notice: t(:updated_f, model: t(:trading, scope: 'activerecord.models'))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tradings/1
  def destroy
    @trading.destroy
    redirect_to tradings_url, notice: t(:deleted_f, model: t(:trading, scope: 'activerecord.models'))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trading
    @trading = current_user.tradings.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def trading_params
    params.require(:trading)
          .permit(:date, :value, :amount, :kind, :user_id, :stock_id)
          .merge(user_id: current_user.id, wallet: current_user.wallets.first)
  end
end
