class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :description
      t.integer :num_rooms
      t.string :city
      t.string :country
      t.boolean :is_active

      t.references :agent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
