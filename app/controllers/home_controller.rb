class HomeController < ApplicationController
  skip_before_action :authenticate_agent!

  def index
    @checkin = Time.now
    @checkout = Time.now.advance(days: 1)
    @guests = 1
    @destination_city = ""
    @cities = Hotel.pluck(:city).uniq.map { |city| [city, city] }
    if params[:checkin].present? && params[:checkout].present?
      @checkin = Time.parse(params[:checkin])
      @checkout = Time.parse(params[:checkout])
      @guests = params[:guests].to_i
      @destination_city = params[:destination_city]
      @rooms = Room
        .includes(:hotel)
        .left_joins(:bookings, :hotel)
        .where(
          "(bookings.checkout <= ? OR bookings.checkin >= ? OR bookings.id IS NULL) AND max_persons >= ? AND lower(hotels.city) = ?",
          @checkin,
          @checkout,
          @guests,
          @destination_city.downcase)
        .and(Room.where(is_active: true))
        .order("base_price DESC")
        .distinct
    else
      @rooms = Room.all.order("base_price DESC")
    end
  end
end
