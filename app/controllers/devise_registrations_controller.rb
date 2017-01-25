class DeviseRegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    
    @individual = Individual.create(sign_up_params[:entity_attributes])
    @account = Account.create(number: @individual.inn)
    @role = Role.find_by( definition: "Физ.лицо")
    client_params = sign_up_params.merge(role_id: @role.id, account_id: @account.id, country: 'KGZ')
    @client = @individual.clients.build(client_params.except :entity_attributes )

    # super

    if @client.save
      redirect_to show_wallet_path
    else
      render "new"
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

   private

    def sign_up_params
      allow = [:mobile, :email, :password, :password_confirmation, :entity_attributes => [:first_name, :last_name, :inn, :dob]]
      params.require(resource_name).permit(allow)
    end
end
