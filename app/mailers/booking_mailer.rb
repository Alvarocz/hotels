class BookingMailer < ApplicationMailer
  def new_booking
    @booking = params[:booking]
    passenger = @booking.passengers.first
    mail(to: passenger.email, subject: "Reserva en hoteles.com")
  end
end
