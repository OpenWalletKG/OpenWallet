class BankAdapter

  def add_account(inn, iban, client_type)
    if client_type == 'Corporate'
      esb_type_face = "1"
    else
      esb_type_face = "2"
    end
    client_id = EsbClient.findClient(inn, esb_type_face)['clientId']
    response = EsbClient.findAccount(iban, client_id)

    if response['ErrCode'] == '0'
      response['accountId']
    else
      false
    end
  end
end