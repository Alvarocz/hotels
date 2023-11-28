class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :room

  has_many :contacts
  has_many :passengers

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :passengers
end