class TradingsController < ApplicationController
  before_action :set_trading, only: %i[show destroy]

  # GET /tradings
  def index
    authorize Trading, :index?
    @search = current_user.tradings.ransack(params[:q])
    @tradings = @search.result.includes(:stock)
  end

  # GET /tradings/1
  def show
    authorize @trading, :show?
  end

  # GET /tradings/new
  def new
    @trading = Trading.new
    authorize @trading, :new?
  end

  # POST /tradings
  def create
    @trading = Trading.new(trading_params)
    authorize @trading, :create?

    if @trading.save
      redirect_to tradings_url, notice: t(:created_f, model: t(:trading, scope: 'activerecord.models'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /tradings/1
  def destroy
    authorize @trading, :destroy?
    @trading.destroy
    redirect_to tradings_url, notice: t(:deleted_f, model: t(:trading, scope: 'activerecord.models'))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trading
    @trading = current_user.tradings.find(params[:id])
  rescue StandardError
    raise Pundit::NotAuthorizedError
  end

  # Only allow a list of trusted parameters through.
  def trading_params
    params.require(:trading)
          .permit(:date, :value, :total_value, :amount, :kind)
          .merge(user: current_user,
                 wallet: current_user.main_wallet,
                 stock: set_stock, asset: set_asset)
  end

  def set_stock
    Stock.find_or_create_by(code: params[:trading][:stock]) if action_name == 'create' && params[:trading][:stock]
  end

  def set_asset
    Asset.find_or_create_by(stock: set_stock, user: current_user, wallet: current_user.main_wallet)
  end
end
