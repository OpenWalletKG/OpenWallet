module TwilioMessageSender
  def self.send_otp_code(phone, otp_code)
    account_sid = ENV['TWILIO_ACCOUNT_SID'] 
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)
    message = client.account.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to:   phone,
      body: otp_code
      })

    message
  end
end