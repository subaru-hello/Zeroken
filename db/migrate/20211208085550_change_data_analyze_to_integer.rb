class ChangeDataAnalyzeToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :analyzes, :next_motivation, :integer, default: 0
    change_column :analyzes, :alcohol_strongness, :integer, default: 0
  end
end
