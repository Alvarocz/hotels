class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :record_locator
      t.datetime :checkin
      t.datetime :checkout
      t.float :total_fare
      t.float :total_tax
      t.references :hotel, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
