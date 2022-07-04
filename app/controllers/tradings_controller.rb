class TradingsController < ApplicationController
  before_action :set_trading, only: %i[show edit update destroy]

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

  # GET /tradings/1/edit
  def edit
    authorize @trading, :edit?
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

  # PATCH/PUT /tradings/1
  def update
    authorize @trading, :update?

    if @trading.update(trading_params)
      redirect_to tradings_url, notice: t(:updated_f, model: t(:trading, scope: 'activerecord.models'))
    else
      render :edit, status: :unprocessable_entity
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
          .permit(:date, :value, :amount, :kind)
          .merge(user: current_user,
                 wallet: current_user.main_wallet,
                 stock: set_stock)
  end

  def set_stock
    if action_name == 'create' && params[:trading][:stock]
      Stock.find_or_create_by(code: params[:trading][:stock])
    elsif action_name == 'update' && !params[:trading][:stock]
      @trading.stock
    elsif action_name == 'update' && params[:trading][:stock]
      Stock.find_or_create_by(code: params[:trading][:stock])
    end
  end
end
