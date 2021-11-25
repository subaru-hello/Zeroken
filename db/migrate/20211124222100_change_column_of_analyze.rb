class ChangeColumnOfAnalyze < ActiveRecord::Migration[6.1]
  def change
    remove_column :analyzes, :shuchedule, :integer
  end
end
