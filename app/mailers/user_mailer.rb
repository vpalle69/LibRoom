class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(booking,room,emailid,emailid1)
    @room=room
    @booking=booking
    @emailid=emailid
    @emailid1=emailid1
    mail(to: @emailid, subject: 'NCSU ROOM BOOKING')
    mail(to: @emailid1, subject: 'NCSU ROOM BOOKING')
  end
end
