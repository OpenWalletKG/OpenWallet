class Corporate < ApplicationRecord
  has_one :client, dependent: :destroy, as: :entity

  has_many :corporate_individuals

  has_many :employees, through: :corporate_individuals
  has_many :individuals, through: :corporate_individuals

  validates :registration_number, presence: true,
            uniqueness: true

  validates :in, presence: true,
            uniqueness: true

  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: ":style/missing.png"
  validates_attachment_content_type :image, 
                    content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']
end
