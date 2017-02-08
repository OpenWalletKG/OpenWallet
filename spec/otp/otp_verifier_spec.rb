require 'rails_helper'

RSpec.describe OtpVerifier do
  describe '.verify_otp_code' do
    it 'should return true if code is verified' do
      response = OtpSender.new('+996700600500')
      response.send_otp_code
      otp_code = response.as_json['otp_code']
      checker = OtpVerifier.new('+996700600500')
      expect(checker.verify_otp_code(otp_code)).to eq(true)
    end
  end

  describe '.get_verified_otp' do
    it 'should return "0000" before verification and ssould return otp_code after verification' do
      response = OtpSender.new('+996700600500')
      response.send_otp_code
      otp_code = response.as_json['otp_code']
      checker = OtpVerifier.new('+996700600500')
      expect(checker.get_verified_otp).to eq("0000")
      checker.verify_otp_code(otp_code)
      expect(checker.get_verified_otp).to eq(otp_code)
    end
  end
end