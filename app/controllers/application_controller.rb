class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :authenticate_user!

  protected

  def layout_by_resource
    if devise_controller?
      'login'
    else
      'application'
    end
  end
end
