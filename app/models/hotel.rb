class Hotel < ApplicationRecord
  belongs_to :agent

  has_many :room_types
  has_many :rooms
end