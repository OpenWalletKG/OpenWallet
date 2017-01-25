class Client < ApplicationRecord
  belongs_to :account

  belongs_to :role

  belongs_to :entity, polymorphic: true

  validates :mobile, presence: true,
            uniqueness: true,
            # format: { with: /^\d+$/, message: "bad format" }
            format: { without: /\D/, message: "only digit, please "}

  validates :country, presence: true

  # validates :password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # belongs_to :individual
  # accepts_nested_attributes_for :entity
end
