class AlcoholInVeins < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohol_in_veins do |t|
      t.integer :percentage
      t.timestamps
    end
  end
end
