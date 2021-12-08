class AddColumnToAnalyze < ActiveRecord::Migration[6.1]
  def change
    remove_column :analyzes, :sake_strongness_types, :string
    add_column :analyzes, :alcohol_strongness, :string
  end
end
