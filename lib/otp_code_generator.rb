module OtpCodeGenerator
  def self.generate
    otp = rand(0001..9999).to_s.rjust(4, "0")
  end
end