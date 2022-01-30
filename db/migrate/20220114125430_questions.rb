class Questions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :not_answered
      t.timestamps
    end
  end
end
