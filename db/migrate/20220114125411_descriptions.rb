class Descriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :descriptions do |t|
      t.integer :explanation
      t.timestamps
    end
  end
end
