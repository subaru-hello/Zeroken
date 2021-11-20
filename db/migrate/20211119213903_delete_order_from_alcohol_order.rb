class DeleteOrderFromAlcoholOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :alcohol_orders, :order, :integer
  end
end
