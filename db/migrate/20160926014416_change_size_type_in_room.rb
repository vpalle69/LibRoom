class ChangeSizeTypeInRoom < ActiveRecord::Migration[5.0]
  def up

    change_column :rooms, :size, :string


  end

  def down

    change_column :rooms, :size, :integer

  end
end
