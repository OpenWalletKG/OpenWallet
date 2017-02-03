class OtpRegistrationController < ApplicationController

  def initialize(phone)
    @phone = phone
    @phone.insert(0, "+")
    DraftPhoneRegistration.create(phone: @phone) if !DraftPhoneRegistration.find_by(phone: @phone).present? 
    @phone_registration = DraftPhoneRegistration.find_by(phone: @phone)
    @otp_code_ttl = 120
    @otp_code_resend_time = 30
  end  

  def send_otp_code
    @try_counts = get_try_counts
    if is_phone_banned && (@try_counts < 5)
      @otp_code = OtpCodeGenerator.generate
      @try_counts += 1
      OtpRegistration.create( draft_phone_registration_id: @phone_registration.id, 
                              pin: @otp_code, 
                              try_count: @try_counts)
      twilio_response = MessageSender.send_otp_code(@phone, @otp_code)
      puts twilio_response.status
      success_message = "A PIN code was successfully sent to your phone."
      # flash[:success] = success_message
    else
      set_phone_banned
      reset_phone_try_counts
      @ban_end = TimeDifference.between(Time.now, DraftPhoneRegistration.find_by(phone: @phone).end_of_ban).humanize
      redirect_to root_path
      error_message = <<-HEREDOC 
        We're sorry this phone number is banned in the system.
        You can try again in #{@ban_end}.
      HEREDOC
      # flash[:error] = error_message
    end 
  end

  def verify_otp_code(otp_code)
    current_registration = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
    current_registration.try_count += 1
    if current_registration.pin == otp_code && is_otp_code_active
      current_registration.succeeded = true
      current_registration.save
      return true
    else
      current_registration.succeeded = false
      current_registration.save
      return false
    end
  end  

  # private 

  def resend_otp_code 
    if Time.now > (OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last.created_at + (@otp_code_ttl - @otp_code_resend_time))
      @otp_code = OtpCodeGenerator.generate
      current_registration = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
      current_registration.update_attribute(:pin, @otp_code)
    end
    twilio_response = MessageSender.send_otp_code(@phone, @otp_code)
    puts twilio_response.status
  end

  def is_otp_code_active
    if Time.now < (OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last.created_at + @otp_code_ttl)
      return true
    else
      return false
    end
  end

  def get_try_counts
    last_otp = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
    if last_otp.nil?
      return 0
    else
      return last_otp.try_count
    end
  end

  def is_phone_banned
    if @phone_registration.end_of_ban.nil? || @phone_registration.end_of_ban <= Time.now
      return true
    else 
      return false
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