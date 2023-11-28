class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :type
      t.string :name
      t.string :phone_number
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
