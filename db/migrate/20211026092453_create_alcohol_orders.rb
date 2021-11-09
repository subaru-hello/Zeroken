class CreateAlcoholOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohol_orders do |t|
      t.references :analyze
      t.references :alcohol
      t.integer :order
      t.timestamps
    end
  end
end
