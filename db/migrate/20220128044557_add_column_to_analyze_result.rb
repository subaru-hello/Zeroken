class AddColumnToAnalyzeResult < ActiveRecord::Migration[6.1]
  def change
    add_column :analyze_results, :first_alcohol, :integer
    add_column :analyze_results, :second_alcohol,:integer
    add_column :analyze_results, :third_alcohol,:integer
    add_column :analyze_results, :forth_alcohol,:integer
  end
end
