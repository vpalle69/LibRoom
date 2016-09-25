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
    @room = Room.find_by(roomno: params[:roomno])
    return @booking,@room
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create

    @booking = Booking.new(booking_params)
    @room = Room.where("roomno = ?", @booking.roomno)
    if @room.nil?
      flash[:notice] = "Room not found !"
      render 'bookings/new' and return
    end
    if current_user.usertype != "Admin" or current_user.usertype != 'Super Admin'
      @user = User.where("email LIKE ?", current_user.usertype)
    else
      @user = User.where("email LIKE ?", params[:booked_user])
      if @user.nil? or @user.empty?
        flash[:notice] = "User not found !"
        render 'bookings/new' and return
      end
    end
    @current_bookings = Booking.where("roomno = ? and ? <= endtime and starttime <= ? ", @booking.roomno,
                                              @booking.starttime, @booking.endtime)
    if not @current_bookings.nil? and not @current_bookings.empty?
      puts @current_bookings.first.starttime
      puts @current_bookings.first.roomno
      flash[:notice] = "This room is not available at this time. Conflicts with other reservation which starts at #{@current_bookings.first.starttime} "
      render 'bookings/new' and return
    end
    if @booking.starttime > @booking.endtime
      flash[:notice] = "ERROR: Booking start  time can't be greater than end time"
      render 'bookings/new' and return
    end

    if @booking.starttime + 2.hours < @booking.endtime
      flash[:notice] = "ERROR : Booking can be made only for 2 hours at a time"
      render 'bookings/new' and return
    end
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
