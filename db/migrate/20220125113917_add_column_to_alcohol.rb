class AddColumnToAlcohol < ActiveRecord::Migration[6.1]
  def change
    add_column :alcohols, :capacity_per_glass, :integer
  end
end
