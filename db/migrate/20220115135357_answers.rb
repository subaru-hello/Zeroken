class Answers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :questions, foreign_key: true
      t.integer :point
      t.string :choice
      t.timestamps
    end
  end
end
