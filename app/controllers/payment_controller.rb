class PaymentController < WalletController
  before_action :authenticate_client!

  def new
    @account = Account.new
    @accounts_all = Account.all.where(client_id: current_client.id, type_money: 'bank')
  end

  def create
    @account = Account.new(account_params)
    request = EsbClient.findClient(current_client.entity.in, '1')
    request_2 = EsbClient.findAccount(account_params['number'], request['clientId'])
    if request_2['ErrCode'] == '0'
      @account.assign_attributes(client_id: current_client.id, type_money: 'bank')
      @bank = Bank.all.map { |bank| [bank.name, bank.id] }
      @account.save
      BankAccount.create(account_id: @account.id, bank_id: params['bank_id'])
    flash[:danger] = "Номер банковского счета успешно добавлен!"
    redirect_to '/wallet/payment/new'
    else
      flash[:danger] = "Номер банковского счета не найден!"
      redirect_to :back
    end
  end
  
  def show
    @accounts_all = Account.all.where(client_id: current_client.id)
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Ваш банковский счет удален"
    redirect_to '/wallet/payment/new'
  end

  private

  def account_params
    params.require(:account).permit(:number, :type_money, :title, :client_id)
  end

  def bank_params
    params.require(:bank).permit(:name, :plugin)
  end

  def bank_account_params
    params.require(:bank_account).permit(:account_id, :bank_id, :bank_account_id)
  end
end
