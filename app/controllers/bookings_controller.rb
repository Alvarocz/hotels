class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @checkin = params[:checkin]
    @checkout = params[:checkout]
    @guests = params[:guests].to_i
    @room = Room.includes(:room_type).find(params[:room_id])
    @total_fare = @room.base_price * @guests
    @total_tax = @total_fare * @room.taxes

    @genders = %w[Masculino Femenino Otro]
    @booking = Booking.new
    @guests.times { @booking.passengers.build }
    1.times { @booking.contacts.build }
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    first_passenger = booking_params[:passengers_attributes]["0"]
    @booking = Booking.new(booking_params)
    @checkin = booking_params[:checkin]
    @checkout = booking_params[:checkout]
    @guests = booking_params[:passengers_attributes].length
    @room = Room.includes(:room_type).find(booking_params[:room_id])
    @booking.contacts.append(Contact.new(
      contact_type: "primary",
      name: "#{first_passenger[:first_name]} #{first_passenger[:last_name]}",
      phone_number: first_passenger[:phone_number]
    ))

    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully created." }
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
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
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
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
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
        passengers_attributes: [
          :id,
          :first_name,
          :last_name,
          :gender,
          :document_type,
          :document_number,
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
