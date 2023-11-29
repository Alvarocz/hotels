class InitializeBooking
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    guests = @params[:guests].to_i
    if guests < 1
      errors.add(:base, "Debe seleccionar al menos un huesped")
      return
    end
    room = Room.includes(:room_type, :hotel).find(@params[:room_id])
    total_fare = room.base_price * guests
    total_tax = total_fare * (room.taxes / 100)

    booking = Booking.new(
      checkin: @params[:checkin],
      checkout: @params[:checkout],
      total_fare: total_fare,
      total_tax: total_tax,
      room: room,
      hotel: room.hotel
    )
    guests.times { booking.passengers.build }
    # Initialize emergency contact
    1.times { booking.contacts.build }
    booking
  end
end