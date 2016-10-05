class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :room, index=true
      t.string :roomno
      t.string :booked_user
      t.datetime :starttime
      t.datetime :endtime
      t.integer  :room_id
      t.integer  :user_id
      t.timestamps
    end
  end
end
