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
    creator = Trading::Creator.call(trading_params)
    @trading = creator.result
    authorize @trading, :create?

    if creator.success?
      @trading.save
      redirect_to tradings_url, notice: t(:created_f, model: t(:trading, scope: 'activerecord.models'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tradings/1
  def update
    creator = Trading::Updater.call(trading_params, @trading)
    @trading = creator.result
    authorize @trading, :update?

    if creator.success?
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
          .permit(:date, :value, :amount, :kind, :stock)
          .merge(user: current_user, wallet: current_user.main_wallet)
  end
end
