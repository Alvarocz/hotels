class Passenger < ApplicationRecord
  belongs_to :booking

  @@gender_options = %w[Masculino Femenino Otro]
  validates_inclusion_of :gender, in: @@gender_options

  def self.gender_options
    @@gender_options.map { |gender| [gender, gender] }
  end
end