class AddForeignKeyToAnalyzeResult < ActiveRecord::Migration[6.1]
  def change
    create_table :analyze_results do |t|
      t.references :user, foreign_key: true
      t.integer :next_motivation
      t.string :description
      t.integer :alcohol_strongness, default: 0
      t.integer :total_alcohol_amounts
      t.timestamps
    end
  end
end
