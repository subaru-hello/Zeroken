class CreateAlcohols < ActiveRecord::Migration[6.1]
  def change
    create_table :alcohols , options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :name, limit: 191
      t.integer :alcohol_percentage
      t.integer :alcohol_amount
      t.integer :pure_alcohol_intake
      t.text :description
      t.timestamps
    end
  end
end
