class EsbClient
  include HTTParty
  base_uri ENV['ESB_API_BASE_URI']

  AGENT0 = 'AGENT0'
  AGENT = 'AGENT'
  SUPPLIER = 'PROVIDER'
  CARD_PROVIDER = 'CARD_PROVIDER'

  CORPORATE  = '1'
  INDIVIDUAL = '2'

  def self.get_individual_type
    INDIVIDUAL
  end

  def self.get_corporate_type
    CORPORATE
  end

  def self.getClient(client_id)
    raise ArgumentError.new("Аргумент client_id не задан") if client_id.empty?
    response = post('/client/v1/getClient',
      { body:
        {
          'clientId': client_id
          }.to_json
        }
      )
    raise ESBError.new(response) if ESBError.hasError(response)
    response['client'].first
  end

  def self.findClient(inn, client_type)
    response = post('/client/v1/findClient',
      { body:
        {
          'IN': inn,
          'clientType': client_type
          }.to_json
        }
      )
  end

  def self.findAccount(num, client_id)
    response = post('/account/v1/findAccount',
      { body:
        {
          'num': num,
          'clientId': client_id
          }.to_json
        }
      )
  end

  def self.getAccountSaldo(account_id)
    response = post('/account/v1/getAccountSaldo',
      { body:
        {
          'accountId': account_id
          }.to_json
        }
      )
  end

  def self.getAccountStatementByPeriod(account_id, date_beg, date_end)
    response = post('/account/v1/getAccountStatement',
      { body:
        {
          'accountId': account_id,
          'dtBeg': date_beg,
          'dtEnd': date_end
          }.to_json
        }
      )
  end

  def self.getAccountStatementByLimit(account_id, limit)
    response = post('/account/v1/getAccountStatement',
      { body:
        {
          'accountId': account_id,
          'limit': limit
          }.to_json
        }
      )
  end

  def self.findAgent(inn, reg_num)
    raise ArgumentError.new("Аргумент IN не задан") if inn.empty?
    raise ArgumentError.new("Аргумент regNum не задан") if reg_num.empty?
    response = post('/agent/v1/findAgent',
      { body:
        {
          'IN': inn,
          'regNum': reg_num
          }.to_json
        }
      )
    raise ESBError.new(response) if ESBError.hasError(response)
    response['agentId']
  end

  def self.getAgent(agent_id)
    raise ArgumentError.new("Аргумент agentId не задан") if agent_id.empty?
    response = post('/agent/v1/getAgent',
      { body:
        {
          'agentId': agent_id
          }.to_json
        }
      )
    raise ESBError.new(response) if ESBError.hasError(response)
    response
  end

  def self.getAccountCalendar(account_id, date_month, date_year)
    response = post('/account/v1/getAccountCalendar',
      { body:
        {
          'accountId': account_id,
          'dtMonth': date_month,
          'dtYear': date_year
          }.to_json
        }
      )
  end

  def self.addTransfer(agent_id, account_id, client_id, amount, target, tpay_document_id="")
    params = transfer_params(agent_id, account_id, client_id, amount, tpay_document_id, target)
    path = '/document/v1/addTransfer'
    return transfer(path, { body: params.to_json} )
  end

  def self.removeTransfer(agent_id, account_id, client_id, amount, target, tpay_document_id)
    params = transfer_params(agent_id, account_id, client_id, amount, tpay_document_id, target)
    path = '/document/v1/removeTransfer'
    return transfer(path, { body: params.to_json})
  end

  def self.addTransferCard(agent_id, client_id, amount, target, agent_id_provider, tpay_document_id="")
    path = '/document/v1/addTransferCard'
    params = {
        agentId: agent_id,
        agentIdProvider: agent_id_provider,
        clientId: client_id,
        summ: amount,
        transId: tpay_document_id,
        nazn: target
    }
    return transfer(path, { body: params.to_json })
  end

  def self.removeTransferCard(amount, target, agent_id_provider, tpay_document_id)
    path = '/document/v1/removeTransferCard'
    params = {
      agentIdProvider: agent_id_provider,
      summ: amount,
      transId: tpay_document_id,
      nazn: target
    }
  end

  def self.getStatus(document_id)
    response = post('/document/v1/getStatus',
      { body:
        {
          'fold': document_id
          }.to_json
        }
      )
  end

  def self.executeTransfer(document_id)
    response = post('/document/v1/executeTransfer',
      { body:
        {
          'fold': document_id
          }.to_json
        }
      )
  end

  def self.transfer_params(agent_id, account_id, client_id, amount, target, tpay_document_id)
    {
      'agentId': agent_id,
      'accountId': account_id,
      'clientId': client_id,
      'summ': amount,
      'nazn': target,
      'transId': tpay_document_id
      }
  end

  def self.transfer(path, params)
    response = post(path, params)
  end

  private

  def post(path, options = {})
    options[:headers] = { 'Content-Type' => 'application/json' }

    self.class.post(path, options)
  end

end


class ESBError < Exception
  attr_reader :msg

  def initialize(msg)
    if msg.class == Hash
      @msg = msg['ErrText']
    else
      @msg = msg
    end
  end

  def self.hasError( response )
    return true if response['ErrCode'] != '0'
    false
  end

end