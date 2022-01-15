class AlcoholInVeins < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohol_in_veins do |t|
      t.references :analyze_results, foreign_key: true
      t.integer :total_points
      t.timestamps
    end
  end
end
