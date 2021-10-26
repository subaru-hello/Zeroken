class CreateAnalyzes < ActiveRecord::Migration[6.1]
  def change
    create_table :analyzes do |t|
      t.references :user, foreign_key: true
      t.integer :total_points
      t.integer :drunk_types, null: false, default: 0
      t.integer :resistance_types, null: false, default: 0
      t.timestamps
    end
  end
end
