class Registration

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :client


  def initialize( registration_params )
    case registration_params[:registration].capitalize

      when "Individual"
        @klass = Individual
        @entity_params = registration_params.require("individual").permit( :first_name,
                                                                           :last_name,
                                                                           :dob,
                                                                           :in  )
        @role = Role.find(3)
      # TODO: Role detect

      when "Corporate"
        @klass = Corporate
        @entity_params = registration_params.require("corporate").permit( :registration_number,
                                                                          :address,
                                                                          :in )
        @role = Role.find(1)
      # TODO: Role detect
      # TODO: Bank, get employees and registration as Individuals

      else
        @klass = nil
        @entity_params = nil
        @role = nil
        # TODO: exception

    end

    @client_params     = registration_params.require("client").permit( :mobile,
                                                                       :email,
                                                                       :password,
                                                                       :password_confirmation,
                                                                       :country  )

  end


  def register_client

    entity  = @klass.create( @entity_params )

    account = Account.create( generate_account_number( entity.in.to_i ) )

    @client = Client.create(  mobile:       @client_params[:mobile],
                              account_id:   account.id,
                              entity_id:    entity.id,
                              entity_type:  @klass.to_s,
                              role_id:      @role.id,
                              password:               @client_params[:password],
                              password_confirmation:  @client_params[:password_confirmation],
                              country:                @client_params[:country],
                              email:                  @client_params[:email]  )


    # TODO: rollback if !@client.persisted?
  end


  def persisted?
    !!@client
  end


  def rollback
    #TODO: rollback
  end

  private

  def generate_account_number( unique_identifier )
    { number: Base58.encode( unique_identifier ) }
  end

end

=begin

EXAMPLES registration_params for initialize:

  ActionController::Parameters.new({
      registration: 'Individual',
      client:  {  mobile: '79993423112',
                  email: 'just_user@mail.ru',
                  password:'asdfasdf',
                  password_confirmation:'asdfasdf',
                  country:'KGZ' },
      individual: {   first_name: 'Marat',
                      last_name: 'Kaiypov',
                      dob: Time.now,
                      in:'3700225544' }
  })

  ActionController::Parameters.new({
      registration: 'Corporate',
      client:  {  mobile: '77779455423',
                  email: 'info@trader.kz',
                  password:'asdfasdf',
                  password_confirmation:'asdfasdf',
                  country:'KAZ' },
      corporate: {    registration_number: 'R203341424',
                      address:'Almaty',
                      in: '34441245123' }
  })

=end