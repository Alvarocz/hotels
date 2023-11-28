class RenameContactType < ActiveRecord::Migration[7.1]
  def change
    rename_column :contacts, :type, :contact_type
  end
end
