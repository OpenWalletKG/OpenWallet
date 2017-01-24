class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :mobile, :email,{individual_attributes: [:first_name,:id]}])
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :email, :password, :current_password, :mobile,{individual_attributes: [:first_name,:id]}) }
  end

end

