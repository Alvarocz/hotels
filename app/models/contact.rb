class Contact < ApplicationRecord
  belongs_to :booking

  validates :name, presence: true
  validates :phone_number, presence: true
end