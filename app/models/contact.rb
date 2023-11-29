class Contact < ApplicationRecord
  after_initialize :default_values

  belongs_to :booking

  validates :name, presence: true
  validates :phone_number, presence: true

  private
    def default_values
      self.contact_type ||= "emergency"
    end
end