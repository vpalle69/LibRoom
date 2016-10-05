class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end
  def search
    search_room = params[:room].reject {|key, value| value.empty? }
    if search_room.values.empty?
      sql_query = "select * from rooms"
      @rooms = Room.find_by_sql(sql_query)
      return @rooms
    else
      sql_query = "select * from rooms where "
      i = 1
      #Formation of SQL Query to show matching users to the search criteria.
      search_room.each do |key, value|
        sql_query = sql_query + "lower(#{key}) LIKE lower('%#{value}%')"
        if(i < search_room.length)
          sql_query = sql_query + " AND "
          i += 1
        end
      end
      @rooms = Room.find_by_sql(sql_query)
    end
  end
  def view_reservation
    @bookings=Booking.where(roomno: params[:roomno])
    #render plain @bookings.inspect
    return @bookings
  end
  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:roomno, :building, :size, :status)
    end
end
