class Client < ApplicationRecord
  belongs_to :account

  belongs_to :role

  belongs_to :entity, polymorphic: true

  validates :mobile, presence: true,
            uniqueness: true,
            # format: { with: /^\d+$/, message: "bad format" }
            format: { without: /\D/, message: "only digit, please "}

  validates :country, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

end


