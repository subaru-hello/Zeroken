class Favorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
    t.references :users, foreign_key: true
    t.references :alcohols, foreign_key: true
    end
  end
end
