class OtpRegistrationController < ApplicationController

  def new
    mobile = params[:mobile]
    mobile.insert(0, "+")
    @otp = OtpSender.new(mobile)
    @otp.send_otp_code
    byebug
  end

  def otp_params
    params.require(:mobile).permit(:mobile)
  end
end