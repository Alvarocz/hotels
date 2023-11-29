class SearchBookings
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    record_locator = @params[:record_locator]
    document_number = @params[:document_number]
    if record_locator.present?
      bookings = Booking.includes(:hotel, room: [:room_type]).where(record_locator: record_locator)
    elsif document_number.present?
      bookings = Booking
        .includes(:hotel, room: [:room_type])
        .joins(:passengers)
        .where("passengers.document_number = ?", document_number)
        .distinct
    else
      bookings = Booking.none
    end
    bookings.order(created_at: :desc)
  end
end