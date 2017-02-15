class BankHandler

  def add_account(inn, account, type_face)
    if type_face == 'Corporate'
      esb_type_face = 1
    else
      esb_type_face = 2
    end

    client_id = EsbClient.findClient(inn, esb_type_face)
    account_id = EsbClient.findAccount(account, client_id)

    if account_id['ErrCode'] == '0'
      true
    else
      false
    end
  end
end