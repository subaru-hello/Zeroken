class AddOrderToAlcohol < ActiveRecord::Migration[6.1]
  def change
    add_column :alcohols, :order, :integer
  end
end
