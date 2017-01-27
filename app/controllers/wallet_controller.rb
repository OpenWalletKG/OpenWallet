class WalletController < ApplicationController
  before_action :authenticate_client!
  layout 'wallet'

  def show
  end
end
