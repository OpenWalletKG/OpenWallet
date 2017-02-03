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
  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: ":style/missing.png"
  validates_attachment_content_type :image, 
                    content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

end


