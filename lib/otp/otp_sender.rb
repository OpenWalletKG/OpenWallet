class OtpSender
  OTP_CODE_TTL = 120
  OTP_CODE_RESEND_TIME = 30

  def initialize(phone_number)
    @phone_number = phone_number
    phone_registration
  end

  def phone_registration
    @phone_registration ||= begin
      pr = DraftPhoneRegistration.find_by(phone: @phone_number)
      pr = DraftPhoneRegistration.create(phone: @phone_number) if pr.nil?
      pr
    end
  end

  def send_otp_code
    @try_counts = get_try_counts
    if !is_phone_banned && (@try_counts < 5)
      if Rails.env.test?
        @otp_code = 1234
      else
      @otp_code = OtpCodeGenerator.generate
      end
      @try_counts += 1
      OtpRegistration.create( draft_phone_registration_id: @phone_registration.id, 
                              pin: @otp_code, 
                              try_count: @try_counts)
      twilio_response = MessageSender.send_otp_code(@phone_number, @otp_code)
      puts twilio_response.status
      success_message = "A PIN code was successfully sent to your phone."
      # flash[:success] = success_message
    else
      set_phone_banned
      reset_phone_try_counts
      @ban_end = TimeDifference.between(Time.now, DraftPhoneRegistration.find_by(phone: @phone_number).end_of_ban).humanize
      error_message = <<-HEREDOC 
        We're sorry this phone number is banned in the system.
        You can try again in #{@ban_end}.
      HEREDOC
      # flash[:error] = error_message
    end 
  end

  alias :resend_otp_code :send_otp_code

  def get_try_counts
    last_otp = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
    if last_otp.nil?
      return 0
    else
      return last_otp.try_count
    end
  end

  private 

  def is_otp_code_active
    if Time.now < (OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last.created_at + OTP_CODE_TTL)
      return true
    else
      return false
    end
  end

  def is_phone_banned
    if @phone_registration.end_of_ban.nil?
      return false
    elsif @phone_registration.end_of_ban <= Time.now
      return false
    else
      return true
    end
  end

  def set_phone_banned
    @phone_registration.end_of_ban = Time.now + 10.days
    @phone_registration.save
  end

  def reset_phone_try_counts
    OtpRegistration.create( draft_phone_registration_id: @phone_registration.id, 
                            pin: 0, 
                            try_count: 0)
  end

end