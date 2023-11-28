class RoomType < ApplicationRecord
  belongs_to :hotel
  has_many :rooms, dependent: :destroy
end