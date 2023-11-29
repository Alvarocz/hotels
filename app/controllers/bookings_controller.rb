class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    command = SearchBookings.call(params)
    @bookings = command.result
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @genders = %w[Masculino Femenino Otro]
    command = InitializeBooking.call(params)
    if command.success?
      @booking = command.result
    else
      @booking = Booking.new
      flash.now[:alert] = command.errors.full_messages.to_sentence
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    command = CreateBooking.call(booking_params)
    @booking = command.result
    respond_to do |format|
      if @booking.save
        BookingMailer.with(booking: @booking).new_booking.deliver_later
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
