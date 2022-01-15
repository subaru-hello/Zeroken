class AnalyzeResults < ActiveRecord::Migration[6.1]
  def change
    create_table :analyze_results do |t|
      t.references :user, foreign_key: true
      t.integer :total_points
      t.integer :alcohol_strongness, default: 0
      t.integer :total_alcohol_amounts, default: 0
      t.integer :alcohol_first
      t.integer :alcohol_second
      t.integer :alcohol_third
      t.integer :alcohol_forth
      t.timestamps
    end
  end
end
