class BuyController < ApplicationController
  def new
  end

  def create
    
    transfer = params.permit(:sum)

    BuyMoney.new(transfer[:account_id], 
                 transfer[:client_id], 
                 transfer[:sum], 
                 "target", 
                 "t_pay_document_id",
                 current_client
                 )
    redirect_to :back
  end
end
