class CreatePassengers < ActiveRecord::Migration[7.1]
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birth_date
      t.string :gender
      t.string :document_type
      t.string :document_number
      t.string :email
      t.string :phone_number
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
