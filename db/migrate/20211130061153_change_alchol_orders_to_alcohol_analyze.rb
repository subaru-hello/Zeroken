class ChangeAlcholOrdersToAlcoholAnalyze < ActiveRecord::Migration[6.1]
  def change
    rename_table :alcohol_orders, :alcohol_analyzes
  end
end
