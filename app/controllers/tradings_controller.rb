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
    creator = Trading::Creator.call(trading_params)
    @trading = creator.result

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

    if creator.success?
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
          .permit(:date, :value, :amount, :kind, :stock)
          .merge(user: current_user, wallet: current_user.main_wallet)
  end
end
