class DeviseRegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  def create
    registration_params = params.require("client")
    registration = Registration.new( registration_params )
    registration.register_client

    if registration.client.entity_type == 'Corporate'
      client_inn = params[:client][:corporate][:in]
        request = EsbClient.findClient(client_inn, '1')
          if request['clientId'] == nil
            flash[:danger] = "Инн клиента не найден"
           redirect_to root_path and return 
          elsif
            request1 = EsbClient.getClient(request['clientId'])
            unless params[:client][:corporate][:registration_number] == request1['client'].first['registrationNumber']
             flash[:danger] = "Регистрационный номер не совпадает с номером в банке"
             redirect_to root_path and return
            end
        end

    else registration.client.entity_type == 'Individual'
    end
    
    resource = registration.client

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
end