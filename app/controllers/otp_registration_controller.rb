class OtpRegistrationController < ApplicationController

  def initialize(phone)
    @phone = phone
    @phone.insert(0, "+")
    DraftPhoneRegistration.create(phone: @phone) if !DraftPhoneRegistration.find_by(phone: @phone).present? 
    @phone_registration = DraftPhoneRegistration.find_by(phone: @phone)
  end  

  def new
    @client = Client.find(1)
  end

  def create
  end

  def update
  end

  def send_otp_code_to(phone)
    # @phone = params[:mobile]
    
    @try_counts = get_try_counts(@phone_registration) 
    if check_banned_phone(@phone) && (@try_counts < 5)
      @otp_code = OtpCodeGenerator.generate
      @try_counts += 1
      OtpRegistration.create( draft_phone_registration_id: @phone_registration.id, 
                              pin: @otp_code, 
                              try_count: @try_counts)
      MessageSender.send_otp_code(@phone, @otp_code)
    else
      set_phone_banned(@phone)
      reset_phone_try_counts(@phone)
      @ban_end = TimeDifference.between(Time.now, DraftPhoneRegistration.find_by(phone: @phone).end_of_ban).humanize
      redirect_to root_path
      error_message = <<-HEREDOC 
        We're sorry this phone number is banned in the system.
        You can try again in #{@ban_end}.
      HEREDOC
      flash[:error] = error_message
    end 
  end

  def verify_otp_code(phone, otp_code)
    phone_registration = DraftPhoneRegistration.find_by(phone: phone)
    current_registration = OtpRegistration.where(phone_registration_id: curent_phone_registration.id)
    if current_registration.pin == otp_code && current_registration.created_at < Time.now
      curren_registration.succeed = true
      return true
    else
      curren_registration.succeed = false
      return false
    end
  end  


  private 

  def is_active(phone, otp_code)
    
  end

  def get_try_counts(phone_registration)
    last_otp = OtpRegistration.where(draft_phone_registration_id: phone_registration.id).last
    if last_otp.nil?
      return 0
    else
      return last_otp.try_count
    end
  end

  def check_banned_phone(phone)
    current_phone = DraftPhoneRegistration.find_by(phone: phone)
    if current_phone.end_of_ban.nil? || current_phone.end_of_ban <= Time.now
      return true
    else 
      return false
    end
  end

  def set_phone_banned(phone)
    current_phone = DraftPhoneRegistration.find_by(phone: phone)
    current_phone.end_of_ban = Time.now + 10.days
    current_phone.save
  end

  def reset_phone_try_counts(phone)
    current_phone = DraftPhoneRegistration.find_by(phone: phone)
    OtpRegistration.create( draft_phone_registration_id: @phone_registration.id, 
                            pin: 0, 
                            try_count: 0)
  end

end

# create_table "draft_phone_registrations", force: :cascade do |t|
#     t.string   "phone"
#     t.datetime "end_of_ban"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "otp_registrations", force: :cascade do |t|
#     t.integer  "draft_phone_registration_id"
#     t.string   "pin"
#     t.integer  "try_account"
#     t.boolean  "succeeded"
#     t.datetime "created_at",                  null: false
#     t.datetime "updated_at",                  null: false
#     t.index ["draft_first_registration_id"], name: "index_otp_registrations_on_draft_first_registration_id", using: :btree
#   end