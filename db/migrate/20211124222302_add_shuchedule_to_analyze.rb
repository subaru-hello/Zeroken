class AddShucheduleToAnalyze < ActiveRecord::Migration[6.1]
  def change
    add_column :analyzes, :shuchedule, :integer
  end
end
