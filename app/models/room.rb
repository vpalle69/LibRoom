class Room < ApplicationRecord
  validates :roomno, :presence => true, :uniqueness => true
  validates :size, :presence => true
  validates :building,  :presence => true
  has_many :bookings, dependent: :destroy
end