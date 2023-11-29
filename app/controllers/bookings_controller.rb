class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    record_locator = params[:record_locator]
    document_number = params[:document_number]
    if record_locator.present?
      @bookings = Booking.includes(:hotel, room: [:room_type]).where(record_locator: record_locator)
    elsif document_number.present?
      @bookings = Booking
        .includes(:hotel, room: [:room_type])
        .joins(:passengers)
        .where("passengers.document_number = ?", document_number)
        .distinct
    else
      @bookings = Booking.none
    end
    @bookings.order(created_at: :desc)
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    guests = params[:guests].to_i
    room = Room.includes(:room_type, :hotel).find(params[:room_id])
    total_fare = room.base_price * guests
    total_tax = total_fare * (room.taxes / 100)

    @genders = %w[Masculino Femenino Otro]
    @booking = Booking.new(
      checkin: params[:checkin],
      checkout: params[:checkout],
      total_fare: total_fare,
      total_tax: total_tax,
      room: room,
      hotel: room.hotel
    )
    guests.times { @booking.passengers.build }
    1.times { @booking.contacts.build }
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    first_passenger = booking_params[:passengers_attributes]["0"]
    @booking = Booking.new(booking_params.merge({
      record_locator: ('A'..'Z').to_a.shuffle[0,6].join
    }))
    @booking.contacts << Contact.new(
      contact_type: "primary",
      name: "#{first_passenger[:first_name]} #{first_passenger[:last_name]}",
      phone_number: first_passenger[:phone_number]
    )

    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_url(@booking), notice: "La reserva se ha creado exitosamente." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "La reserva fue actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy!

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "La reserva fue eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.includes(:room, :hotel).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(
        :record_locator,
        :checkin,
        :checkout,
        :total_fare,
        :total_tax,
        :primary_contact_id,
        :emergency_contact_id,
        :room_id,
        :hotel_id,
        passengers_attributes: [
          :id,
          :first_name,
          :last_name,
          :birth_date,
          :gender,
          :document_type,
          :document_number,
          :email,
          :phone_number
        ],
        contacts_attributes: [
          :id,
          :contact_type,
          :name,
          :phone_number
        ]
      )
    end
end
