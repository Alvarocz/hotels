class Room < ApplicationRecord
  belongs_to :room_type
  belongs_to :hotel

  has_many :bookings

  def total_price
    base_price + taxes
  end
end