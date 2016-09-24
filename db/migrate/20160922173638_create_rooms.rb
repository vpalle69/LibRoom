class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :roomno
      t.string :building
      t.integer :size
      t.string :status

      t.timestamps
    end
  end
end
