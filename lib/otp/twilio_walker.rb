class TwilioWalker
  account_sid = ENV['TWILIO_ACCOUNT_SID'] 
  auth_token = ENV['TWILIO_AUTH_TOKEN']

  @client = Twilio::REST::Client.new account_sid, auth_token 
 
  @client.account.messages.list({ }).each do |message| 
    puts message.body 
  end

end