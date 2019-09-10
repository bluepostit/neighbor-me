class Booking < ApplicationRecord
  belongs_to :tool
  belongs_to :user

  validates :collect_time, presence: true
  validates :return_time, presence: true
end
