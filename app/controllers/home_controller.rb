class HomeController < ApplicationController
  skip_before_action :authenticate_agent!

  def index
    @checkin = Time.now
    @checkout = Time.now.advance(days: 1)
    @guests = params[:guests].to_i || 1
    @destination_city = ""
    @cities = Hotel.pluck(:city).uniq.map { |city| [city, city] }

    command = SearchRooms.call(params)
    @rooms = command.result
  end
end
