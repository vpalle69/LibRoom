class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def search
    search_room = params[:room].reject {|key, value| value.empty? }
    if search_room.values.empty?
      redirect_to '/bookings'
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
    return @rooms,@bookings
  end
  def index
    @bookings = Booking.all
    @rooms=Room.all
    return @rooms,@bookings
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:roomno, :booked_user, :starttime, :endtime)
    end
end
