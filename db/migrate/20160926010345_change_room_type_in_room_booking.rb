class ChangeRoomTypeInRoomBooking < ActiveRecord::Migration[5.0]
  def up
    change_column :rooms, :roomno, :string
    change_column :bookings, :roomno, :string
    change_column :rooms, :size, :string


  end

  def down
    change_column :rooms, :roomno, :integer
    change_column :bookings, :roomno, :integer
    change_column :rooms, :size, :integer

  end
end
