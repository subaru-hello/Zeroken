class AddImageToAlcohol < ActiveRecord::Migration[6.1]
  def change
    add_column :alcohols, :image, :string
  end
end
