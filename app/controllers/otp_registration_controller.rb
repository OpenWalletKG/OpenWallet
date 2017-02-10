class OtpRegistrationController < ApplicationController

  def new
    # byebug
    @mobile = params[:mobile]
    @phone = params[:mobile]
    @mobile.insert(0, "+")
    # @otp = DraftPhoneRegistration.last
    @otp = OtpSender.new(@mobile)
    @try_counts = @otp.get_try_counts
    @otp.send_otp_code
    if @try_counts < 5
      @message = "Вам был отправлен код подтверждения!"
      respond_to do |format|
        format.js {}
      end
    else  
      flash[:error] = "Вы превысили количество попыток ввода кода."
      render js: "window.location = '#{root_path}'"
    end  
  end

  def confirm
    @mobile = params[:mobile]
    check = OtpVerifier.new(@mobile)
    @try_counts = check.get_try_counts
    entered_pin = params[:pin]
    @pin_verified = check.verify_otp_code(entered_pin)
    if @pin_verified
      @message = "Ваш номер телефона был подтвержден"
      # render js: "window.location = '#{root_path}'"
      respond_to do |format|
        format.js {}
      end
    elsif @try_counts < 5
      @message = <<-HEREDOC
        Неверный код!
        Пожалуйста запросите код еще раз.
      HEREDOC
      respond_to do |format|
        format.js {}
      end 
    else
      flash[:error] = "Вы превысили количество попыток ввода кода."
      render js: "window.location = '#{root_path}'"
    end  
  end

  private 

  def mobile_params
    params.require(:mobile).permit(:mobile, :pin)
  end

end