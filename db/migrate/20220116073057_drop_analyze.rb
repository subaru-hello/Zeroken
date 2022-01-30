class DropAnalyze < ActiveRecord::Migration[6.1]
  def change
    drop_table :analyzes
  end
end
