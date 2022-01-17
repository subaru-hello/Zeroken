class ChangeTypeOfColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :descriptions, :explanation, :string
  end
end
