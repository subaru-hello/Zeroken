class CreateAlcohols < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohols do |t|
      t.references :alcohol_order
      t.integer :alcohol_types,polymorphic: true, index: true
      t.string :title
      t.integer :alcohol_percentage
      t.text :description
      t.timestamps
    end
  end
end
