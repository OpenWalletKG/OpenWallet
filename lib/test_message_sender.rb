module TestMessageSender
  Sms ||= Struct.new(:from, :to, :body, :status)
  def self.send_otp_code(phone, otp_code)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    current_sms = Sms.new(account_sid, phone, otp_code, "queue")
    directory = Rails.root.join('test', 'fixtures', 'files')
    file = File.open(File.join(directory, 'otp_keeper.txt'), 'w')
    file.write(otp_code)
    file.close
    return current_sms

  end
end
