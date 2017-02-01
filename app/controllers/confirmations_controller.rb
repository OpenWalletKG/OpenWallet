class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    edit_client_registration_path(resource_name, resource)
  end

end