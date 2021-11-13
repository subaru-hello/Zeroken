class AddDescriptionToAnalyze < ActiveRecord::Migration[6.1]
  def change
    add_column :analyzes, :description, :text
  end
end
