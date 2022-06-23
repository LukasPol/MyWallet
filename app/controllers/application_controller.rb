class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  layout :layout_by_resource
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def layout_by_resource
    if devise_controller?
      'login'
    else
      'application'
    end
  end

  def user_not_authorized(_exception)
    flash[:error] = I18n.t(:access_denied, scope: 'errors.messages')
    redirect_back fallback_location: '/'
  end
end
