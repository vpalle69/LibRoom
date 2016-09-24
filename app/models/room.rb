class Room < ApplicationRecord
  validates :roomno, :presence => true, :uniqueness => true
  validates :size, :presence => true
  validates :building,  :presence => true
end