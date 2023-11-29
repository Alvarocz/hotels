class CreateBooking
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    first_passenger = @params[:passengers_attributes]["0"]
    booking = Booking.new(@params.merge({
      record_locator: ('A'..'Z').to_a.shuffle[0,6].join
    }))
    booking.contacts << Contact.new(
      contact_type: "primary",
      name: "#{first_passenger[:first_name]} #{first_passenger[:last_name]}",
      phone_number: first_passenger[:phone_number]
    )
    booking
  end
end