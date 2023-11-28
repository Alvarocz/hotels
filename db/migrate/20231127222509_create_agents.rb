class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :document_type
      t.string :document_number
      t.string :phone_number

      t.timestamps
    end
  end
end
