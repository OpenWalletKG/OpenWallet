class OtpVerifier
  OTP_CODE_TTL = 120

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

  def phone_number
    @phone_number
  end

  def verify_otp_code(otp_code)
    current_registration = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
    return true if current_registration.succeeded
    if (current_registration.pin == otp_code) && is_otp_code_active && !is_phone_banned
      current_registration.succeeded = true
      current_registration.save
      return true
    elsif get_try_counts < 5
      current_registration.succeeded = false
      current_registration.save
      return false
    else
      set_phone_banned
      return false  
    end
  end  

  def get_verified_otp
    current_registration = OtpRegistration.where(draft_phone_registration_id: @phone_registration.id).last
    if !is_phone_banned && current_registration.succeeded
      return current_registration.pin
    else
      return '0000' #phone is not verified.
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
      return true
    else
      return true
    end
  end

  def set_phone_banned
    @phone_registration.end_of_ban = Time.now + 10.days
    @phone_registration.save
  end

end