class SearchRooms
  prepend SimpleCommand
  include ActiveModel::Validations

  def initialize(params)
    @params = params
  end

  def call
    if @params[:checkin].present? && @params[:checkout].present?
      return Room
        .includes(:hotel)
        .left_joins(:bookings, :hotel)
        .where(
          "(bookings.checkout <= ? OR bookings.checkin >= ? OR bookings.id IS NULL) AND max_persons >= ? AND lower(hotels.city) = ?",
          Time.parse(@params[:checkin]),
          Time.parse(@params[:checkout]),
          @params[:guests].to_i,
          @params[:destination_city].downcase)
        .and(Room.where(is_active: true))
        .order("base_price DESC")
        .distinct
    end
    errors.add(:base, 'No se encontraron habitaciones')
  end
end