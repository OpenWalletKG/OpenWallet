class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    show_wallet_path
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
  # before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [ :mobile, :email, {entity_attributes: [:first_name, :last_name, :inn, :dob ]}])
  #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :email, :password, :current_password, :mobile,{individual_attributes: [:first_name,:id]}) }
  # end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) { |client|
  #     client.permit(:email, :mobile, :email, :password, :password_confirmation, {
  #       :entity_attributes => [:first_name, :last_name, :inn, :dob ] }) }
  
  # end

end