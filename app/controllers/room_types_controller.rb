class RoomTypesController < ApplicationController
  before_action :set_room_type, only: %i[ show edit update destroy ]

  # GET /room_types or /room_types.json
  def index
    @room_types = RoomType.all
  end

  # GET /room_types/1 or /room_types/1.json
  def show
  end

  # GET /room_types/new
  def new
    @room_type = RoomType.new
  end

  # GET /room_types/1/edit
  def edit
  end

  # POST /room_types or /room_types.json
  def create
    @room_type = RoomType.new(room_type_params)

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to hotel_url(@room_type.hotel), notice: "El tipo de habitación fue creado." }
        format.json { render :show, status: :created, location: @room_type }
      else
        format.html { redirect_to hotel_url(@room_type.hotel), alert: "No se pudo crear el tipo de habitación." }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_types/1 or /room_types/1.json
  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to hotel_url(@room_type.hotel), notice: "Se actualizo el tipo de habitación." }
        format.json { render :show, status: :ok, location: @room_type }
      else
        format.html { redirect_to hotel_url(@room_type.hotel), alert: "No se pudo actualizar el tipo de habitación." }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_types/1 or /room_types/1.json
  def destroy
    @room_type.destroy!

    respond_to do |format|
      format.html { redirect_to hotel_url(params[:hotel_id]), notice: "El tipo de habitación fue eliminado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_type_params
      params.require(:room_type).permit(:name, :size, :hotel_id)
    end
end
