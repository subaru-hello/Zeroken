class Alcoholanalyzes < ActiveRecord::Migration[6.1]
  def change
    drop_table :alcohol_analyzes
  end
end
