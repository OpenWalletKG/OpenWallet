class RegCorporateAPI < EsbClient
  ROLES_MAP = {
      EsbClient::AGENT0   => Role::AGENT_0,
      EsbClient::AGENT    => Role::AGENT,
      EsbClient::SUPPLIER => Role::SUPPLIER
  }

  def initialize( inn, reg_number)
    @inn = inn
    @reg_number = reg_number
  end

  def get_corporate_role_id
    @agent_id ||= EsbClient.findAgent( @inn, @reg_number )
    @agent    ||= EsbClient.getAgent(@agent_id)
    agent_type = @agent['agentType']
    return ROLES_MAP[agent_type] if ROLES_MAP.has_key?(agent_type)
    raise ESBError.new( "Неопределен тип Corporate - #{agent_type}" )
  end

  def get_corporate_head
    @agent_id ||= EsbClient.findAgent( @inn, @reg_number )
    @agent    ||= EsbClient.getAgent(@agent_id)
    @client   ||= EsbClient.getClient(@agent['clientId'])
    @head     ||= EsbClient.getClient(@client['faseID'])
    {
        in: @head['IN'],
        first_name: @head['firstName'],
        last_name: @head['surName'],
        dob: @head['birthDate'],
        position: @head['Range']
        # TODO: add gender
    }
  end

  def get_corporate_info
    @agent_id ||= EsbClient.findAgent( @inn, @reg_number )
    @agent    ||= EsbClient.getAgent( @agent_id )
    @client   ||= EsbClient.getClient( @agent['clientId'] )
    {
        full_name: @client['Name'],
        legal_form: @client['legalForm'],
        okpo: @client['codeOkpo']
    }
  end

end
