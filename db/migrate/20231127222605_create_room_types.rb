class CreateRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :room_types do |t|
      t.string :name
      t.string :size
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
