class PaymentController < WalletController
  before_action :authenticate_client!

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    # current_client.entity_type == "Corporate" = "1"
    request = EsbClient.findClient(current_client.entity.in, '1')
    request_2 = EsbClient.findAccount(account_params['number'], request['clientId'])
    if request_2['ErrCode'] == '0'
      @account.save
    else
      flash[:danger] = "Номер банковского счета не найден"
      redirect_to :back
    end
  end
  
  def show
    
  end

  private

  def account_params
    params.require(:account).permit(:number, :type_money, :title, :client_id)
  end

end
