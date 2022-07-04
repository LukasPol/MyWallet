class ProceedsController < ApplicationController
  before_action :set_proceed, only: %i[show edit update destroy]

  def index
    authorize Proceed, :index?
    @search = current_user.proceeds.ransack(params[:q])
    @proceeds = @search.result.includes(:stock)
  end

  def show
    authorize @proceed, :show?
  end

  def new
    authorize Proceed, :new?
    @proceed = Proceed.new
  end

  def edit
    authorize @proceed, :edit?
  end

  def create
    @proceed = Proceed.new(proceed_params)
    authorize @proceed, :create?

    if @proceed.save
      redirect_to proceeds_url, notice: t(:created_f, model: t(:proceed, scope: 'activerecord.models'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @proceed, :update?
    if @proceed.update(proceed_params)
      redirect_to proceeds_url, notice: t(:updated_f, model: t(:proceed, scope: 'activerecord.models'))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @proceed, :destroy?
    @proceed.destroy
    redirect_to proceeds_url, notice: t(:deleted_f, model: t(:proceed, scope: 'activerecord.models'))
  end

  private

  def set_proceed
    @proceed = current_user.proceeds.find(params[:id])
  rescue StandardError
    raise Pundit::NotAuthorizedError
  end

  def proceed_params
    params.require(:proceed)
          .permit(:date, :value, :amount, :stock_id, :kind)
          .merge(user: current_user, wallet: current_user.main_wallet)
  end
end
