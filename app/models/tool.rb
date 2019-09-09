class Tool < ApplicationRecord
  belongs_to :user
  # photo uploader
  mount_uploader :photo, PhotoUploader
end
