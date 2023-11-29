class SearchRooms
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    if @params[:checkin].present? && @params[:checkout].present? && @params[:destination_city].present?
      rooms = Room
        .includes(:hotel)
        .left_joins(:bookings, :hotel)
        .where(
          "(bookings.checkout <= ? OR bookings.checkin >= ? OR bookings.id IS NULL) AND max_persons >= ? AND lower(hotels.city) = ? AND hotels.is_active = ?",
          Time.parse(@params[:checkin]),
          Time.parse(@params[:checkout]),
          @params[:guests].to_i,
          @params[:destination_city].downcase,
          true)
        .and(Room.where(is_active: true))
        .distinct
    else
      rooms = Room.includes(:hotel).left_joins(:hotel).where("rooms.is_active = ? AND hotels.is_active = ?", true, true).distinct
    end
    rooms.order("base_price DESC")
  end
end