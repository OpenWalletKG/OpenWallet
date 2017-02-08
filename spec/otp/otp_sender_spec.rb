require 'rails_helper'

RSpec.describe OtpSender do
  describe '.initialize' do
    it 'should return typed number' do
      response = OtpSender.new('+996700600500').as_json
      expect(response['phone_number']).to eq('+996700600500')
    end
  end

  describe '.send_otp_code' do
    it 'should return otp code' do
      response = OtpSender.new('+996700600500')
      response.send_otp_code
      expect(response.as_json['otp_code']).not_to be_empty
    end
  end

  describe '.get_try_conts' do
    it "should return otp sender's try counts equal to 1" do
      response = OtpSender.new('+996700600600')
      response.send_otp_code
      expect(response.as_json['try_counts']).to eq(1)
    end
  end

  describe '.resend_otp_code' do
    it "should return otp sender's try counts equal to 2 after resending otp code" do
      response = OtpSender.new('+996700600800')
      response.send_otp_code
      3.times{response.resend_otp_code}
      expect(response.as_json['try_counts']).to eq(4)
    end
  end

  describe '.resend_otp_code' do
    it "should return otp sender's try counts equal to 2 after resending otp code" do
      response = OtpSender.new('+996700600800')
      response.send_otp_code
      expect(response.as_json['ban_end']).to eq(nil)
      6.times{response.resend_otp_code}
      expect(response.as_json['ban_end']).not_to eq(nil)
    end
  end
end