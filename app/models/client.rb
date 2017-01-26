class Client < ApplicationRecord
  belongs_to :account

  belongs_to :role

  belongs_to :entity, polymorphic: true

  validates :mobile, presence: true,
            uniqueness: true,
            # format: { with: /^\d+$/, message: "bad format" }
            format: { without: /\D/, message: "only digit, please "}

  validates :country, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  def self.registration( signup_params )
    registration_type = signup_params.require(:client).permit(:registration_type)[:registration_type].downcase
    case registration_type
      when 'individual'
        registration_individual( signup_params )
      when 'corporate'
        registration_corporate( signup_params )
      else
        nil
    end
  end

  def self.registration_individual(signup_params)
    client_params = signup_params.require(:client).permit(:mobile,:email, :password, :password_confirmation, :country)
    individual_params = signup_params.require(:client).require(:entity_attributes)


    individual = Individual.registration( individual_params )
    account = Account.registration( individual.inn )
    role = Role.find(3)   # TODO: select for roles
                          # TODO: validations
                          # TODO: rollback if failed

    Client.create(mobile: client_params[:mobile],
                  account_id: account.id,
                  entity_id: individual.id,
                  entity_type: "Individual",
                  role_id: role.id,
                  password: client_params[:password],
                  password_confirmation: client_params[:password_confirmation],
                  country: 'KGZ',
                  email: client_params[:email]
    )
  end


  def self.registration_corporate(signup_params)
    nil
  end
end


