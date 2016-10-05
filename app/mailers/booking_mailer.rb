class BookingMailer < ApplicationMailer
  default from: 'vamshidhar.palle@gmail.com'

  def booking_email(starttime,endtime,email,roomno,building)
    @starttime = starttime
    @endtime=endtime
    @building=building
    @roomno=roomno
    mail(to: email, subject: 'Your NCSU Library Room Booking')
  end
end