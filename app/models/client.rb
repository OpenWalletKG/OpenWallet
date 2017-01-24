class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # belongs_to :role

  # belongs_to :entity, polymorphic: true

  # validates :mobile, presence: true,
  #           uniqueness: true,
  #           format: { with: /\d{3}-\d{3}-\d{6}/, message: "bad format" }

  # validates :country, presence: true

  # validates :password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :individual
  # we tell User that we can take company attributes
  accepts_nested_attributes_for :individual
  validates :email, presence: true, uniqueness: {scope: :individual_id}
end
