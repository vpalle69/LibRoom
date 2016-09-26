class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :room, index=true
      t.integer :roomno
      t.string :booked_user
      t.datetime :starttime
      t.datetime :endtime

      t.timestamps
    end
  end
end
