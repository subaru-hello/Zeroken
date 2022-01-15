class Descriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :descriptions do |t|
      t.references :analyze_results, foreign_key: true
      t.integer :explanation
      t.timestamps
    end
  end
end
