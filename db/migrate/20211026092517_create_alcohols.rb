class CreateAlcohols < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohols do |t|
      t.references :alcohol_order
      t.string :name
      t.integer :type
      t.references :alcoholable, polymorphic: true
      t.integer :alcohol_percentage
      t.integer :alcohol_amount
      t.integer :pure_alcohol_intake
      t.text :description
      t.timestamps
    end
  end
end
