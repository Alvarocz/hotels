class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to hotel_url(@room.hotel), notice: "La habitación #{@room.identifier} fue creada exitosamente" }
        format.json { render :show, status: :created, location: @room }
      else
        puts @room.errors
        format.html { redirect_to hotel_url(@room.hotel), alert: "No se pudo crear la habitación" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to hotel_url(@room.hotel), notice: "La habitación #{@room.identifier} fue actualizada exitosamente" }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { redirect_to hotel_url(@room.hotel), alert: "No se pudo actualizar la habitación" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    hotel_id = @room.hotel_id
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to hotel_url(hotel_id), notice: "La habitación fue eliminada" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.includes(:room_type, :hotel).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:room_type_id, :identifier, :base_price, :taxes, :max_persons, :hotel_id, :is_active)
    end
end
