class DraftPhoneRegistration < ApplicationRecord
  has_many :otp_registrations
end
