class CreateAnalyzes < ActiveRecord::Migration[6.1]
  def change
    create_table :analyzes do |t|
      t.references :user, foreign_key: true
      t.integer :total_points
      t.integer :alcohol_strongness, default: 0
      t.integer :next_nomivation_types, default: 0
      t.timestamps
    end
  end
end
