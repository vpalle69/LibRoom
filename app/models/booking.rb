class Booking < ApplicationRecord
 # def user_history
 #   @bookings = Booking.find_by_id(params[:roomno])
  #  @user = @user.courses.sort_by &:id
   # @course_mappings = @user.course_mappings.sort_by &:course_id
    #return @courses, @course_mappings, @user
  #end
  validates :roomno, :booked_user, :starttime,  presence: true
  belongs_to :room
  belongs_to :user
end
