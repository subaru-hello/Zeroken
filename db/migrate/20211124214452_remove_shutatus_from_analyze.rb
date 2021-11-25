class RemoveShutatusFromAnalyze < ActiveRecord::Migration[6.1]
  def change
    remove_column :analyzes, :shutatus, :integer
  end
end
