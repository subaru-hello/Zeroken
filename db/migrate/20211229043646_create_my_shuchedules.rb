class CreateMyShuchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :my_shuchedules do |t|
      t.references :user, foreign_key: true
      t.integer :succeed_result
      t.timestamps
    end
  end
end
