class AddRoomidUseridToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :room_id, :integer
    add_column :bookings, :user_id, :integer
  end
end
