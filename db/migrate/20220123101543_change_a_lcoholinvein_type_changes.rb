class ChangeALcoholinveinTypeChanges < ActiveRecord::Migration[6.1]
  def change
    change_column :alcohol_in_veins, :percentage, :integer
    change_column :alcohols, :alcohol_percentage, :integer
  end
end
