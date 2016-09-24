json.extract! booking, :id, :roomno, :booked_user, :starttime, :endtime, :created_at, :updated_at
json.url booking_url(booking, format: :json)