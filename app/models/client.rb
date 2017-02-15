class Client < ApplicationRecord
  ENTITY = [:individual, :corporate]
  belongs_to :account, dependent: :destroy
  accepts_nested_attributes_for :account

  has_many :contacts

  belongs_to :address, dependent: :destroy
  accepts_nested_attributes_for :address

  belongs_to :role

  belongs_to :entity, polymorphic: true, dependent: :destroy
  accepts_nested_attributes_for :entity

  validates :mobile, presence: true,
            uniqueness: true,
            # format: { with: /^\d+$/, message: "bad format" }
            format: { without: /\D/, message: "only digit, please "}

  validates :country, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: ":style/missing.png"
  validates_attachment_content_type :image, 
                    content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable

  def entity_attributes=(attributes)
    if ENTITY.include?(entity_type.underscore.to_sym)
      self.entity ||= self.entity_type.constantize.new
      self.entity.assign_attributes(attributes)
    end
  end

  def self.register( registration_params )
    case RegistrationParams.get_registration_type(registration_params)
      when "Individual"
        client_attributes = RegistrationParams.get_client_params( registration_params )
        individual_attributes = RegistrationParams.get_individual_params( registration_params )
        address_attributes = RegistrationParams.get_address_params( registration_params )
        if CorporateIndividual.is_employee?( individual_attributes[:in] )
          individual = Individual.find_by_in( individual_attributes[:in] )
          client = Client.create( mobile: client_attributes[:mobile],
                                  email: client_attributes[:email],
                                  password: client_attributes[:password],
                                  password_confirmation: client_attributes[:password_confirmation],
                                  country: client_attributes[:country],
                                  image: client_attributes[:image],
                                  role: Role.get_individual,
                                  entity_type: 'Individual',
                                  entity_id: individual.id,
                                  account_attributes: { number: individual_attributes[:in] },
                                  address_attributes: address_attributes.to_h )
          raise "Ошибка регистрации/валидации" if defined?(client) && client.errors.messages.size != 0
          individual.update_attributes( individual_attributes.to_h )
        else
          client = Client.create(  mobile: client_attributes[:mobile],
                                   email: client_attributes[:email],
                                   password: client_attributes[:password],
                                   password_confirmation: client_attributes[:password_confirmation],
                                   country: client_attributes[:country],
                                   image: client_attributes[:image],
                                   role: Role.get_individual,
                                   entity_type: 'Individual',
                                   entity_attributes: individual_attributes.to_h,
                                   account_attributes: { number: individual_attributes[:in] },
                                   address_attributes: address_attributes.to_h )
        end

      when "Corporate"
        client_attributes = RegistrationParams.get_client_params( registration_params )
        corporate_attributes = RegistrationParams.get_corporate_params( registration_params ).to_h
        esb_corporate = RegCorporateAPI.new(corporate_attributes[:in], corporate_attributes[:registration_number])
        role_id = esb_corporate.get_corporate_role_id
        director = esb_corporate.get_corporate_head
        info = esb_corporate.get_corporate_info
        corporate_attributes.merge!( info )
        address_attributes = RegistrationParams.get_address_params( registration_params )
        client = Client.create(  mobile: client_attributes[:mobile],
                                 email: client_attributes[:email],
                                 password: client_attributes[:password],
                                 password_confirmation: client_attributes[:password_confirmation],
                                 country: client_attributes[:country],
                                 image: client_attributes[:image],
                                 role_id: role_id,
                                 entity_type: 'Corporate',
                                 entity_attributes: corporate_attributes,
                                 account_attributes: { number: corporate_attributes[:in] },
                                 address_attributes: address_attributes.to_h )
        director[:corporate_id] = client.entity_id
        CorporateIndividual.register_head(director)

                                 if client.save
                                   Account.last.update_attributes(client_id: client.id, type_money: 'sed')
                                 end
      else
        raise "Получены неверные параметры"
    end
    raise "Ошибка регистрации/валидации" if defined?(client) && client.errors.messages.size != 0
    client
  end
end



class RegistrationParams
  def self.get_individual_params( registration_params )
    registration_params.require("individual").permit( :first_name,
                                                      :last_name,
                                                      :dob,
                                                      :in,
                                                      :image )
  end

  def self.get_corporate_params( registration_params )
    registration_params.require("corporate").permit( :registration_number,
                                                     :address,
                                                     :in,
                                                     :image )
  end

  def self.get_client_params( registration_params )
    registration_params.require("client").permit( :mobile,
                                                  :email,
                                                  :password,
                                                  :password_confirmation,
                                                  :country,
                                                  :image  )
  end

  def self.get_registration_type( registration_params )
    if registration_params[:registration].blank?
      raise "Неверные поля формы" if get_registration_type(registration_params).blank?
    else
      registration_params[:registration].capitalize
    end
  end

  def self.get_address_params( registration_params )
    registration_params.require("client").permit( :country )
  end
end

