class DeviseRegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  before_action :ensure_pin_verified, only: [:create]


  def show
    @client = Client.new
    @client_type = params[:client_type]
    if !@client_type.nil?
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "Вам необходимо выбрать тип клиента."
      redirect_to new_client_registration_path
    end
  end

  def create
    registration_params = params.require("client")

    begin
      client = Client.register( registration_params )
    # rescue Exception => e
    #   puts e
    #   redirect_to root_path
    #   return
    end

    resource = client

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def show_licence
    send_file("#{Rails.root}/app/assets/files/dogovor.pdf",
              filename: "dogovor.pdf",
              type: "application/pdf",
              disposition: "inline"
    )
  end

  private

  def ensure_pin_verified
    if pin_verified?
      session.delete(:pin_verified)
    else
      render text: 'OTP has not been confirmed', status: 422 and return
    end
  end

  def pin_verified?
    !!session[:pin_verified]
  end

end
