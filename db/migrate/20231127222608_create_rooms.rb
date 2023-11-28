class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :identifier
      t.float :base_price
      t.float :taxes
      t.integer :max_persons
      t.boolean :is_active

      t.references :room_type, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
