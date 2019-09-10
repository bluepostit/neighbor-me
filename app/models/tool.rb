class Tool < ApplicationRecord
  belongs_to :user
  has_many :bookings

  # photo uploader
  mount_uploader :photo, PhotoUploader
  validates :name, :description, presence: true
end
