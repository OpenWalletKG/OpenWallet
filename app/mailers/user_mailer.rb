class UserMailer < ApplicationMailer
  default from: 'socialhubs2016@gmail.com'

  def welcome(client)
    @client = client
    mail(to: client.email, subject: 'Привет!!!')
  end
end
