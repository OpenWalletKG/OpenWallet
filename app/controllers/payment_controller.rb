class PaymentController < WalletController
  before_action :authenticate_client!

  def show
  end

  def new
  end
end
