class Individual < ApplicationRecord
  has_one :client, dependent: :destroy, as: :entity

  has_many :corporate_individuals
  has_many :corporates, through: :corporate_individuals
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :in, presence: true,
            uniqueness: true
  validates :dob, presence: true

  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: ":style/missing.png"
  validates_attachment_content_type :image, 
                    content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

end
