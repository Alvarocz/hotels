class CreateBooking
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    Booking.new(@params.merge({
      record_locator: new_record_locator
    }))
  end

  private

  def new_record_locator
    ('A'..'Z').to_a.shuffle[0,6].join
  end
end