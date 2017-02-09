class Registration

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :client, :entity, :account


  def initialize( registration_params )
    unless registration_params[:registration].blank?
      registration_params[:registration] = registration_params[:registration].capitalize
    end

    case registration_params[:registration]

      when "Individual"
        @entity_class = Individual
        @entity_params = registration_params.require("individual").permit( :first_name,
                                                                           :last_name,
                                                                           :dob,
                                                                           :in, 
                                                                           :image )
        @role = Role.get_individual

      when "Corporate"
        @entity_class = Corporate
        @entity_params = registration_params.require("corporate").permit( :registration_number,
                                                                          :in,
                                                                          :image )
        @role = Role.get_agent
      # TODO: Bank, Role detect if AGENT OR SUPPLIER
      # TODO: Bank, get employees and registration as Individuals

      else
        @entity_class = nil
        @entity_params = nil
        @role = nil
        # TODO: exception

    end

    @client_params     = registration_params.require("client").permit( :mobile,
                                                                       :email,
                                                                       :password,
                                                                       :password_confirmation,
                                                                       :country,
                                                                       :image  )

  end


  def register_client

    # TODO: if @client already exists

    @entity  = @entity_class.create( @entity_params )

    @account = Account.create( number: Account.encode( @entity.in.to_i ) )

    @client = Client.create(  mobile:       @client_params[:mobile],
                              account_id:   @account.id,
                              entity_id:    @entity.id,
                              entity_type:  @entity_class.to_s,
                              role_id:      @role.id,
                              password:               @client_params[:password],
                              password_confirmation:  @client_params[:password_confirmation],
                              country:                @client_params[:country],
                              email:                  @client_params[:email],
                              image:                  @client_params[:image]  )


    @client.persisted?
    # TODO: rollback if !@client.persisted?
  end


  def persisted?
    @client.nil? ? false : @client.persisted?
  end


  def rollback
    #TODO: rollback
  end

  private


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