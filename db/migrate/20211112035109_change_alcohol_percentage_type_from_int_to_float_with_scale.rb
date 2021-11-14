class ChangeAlcoholPercentageTypeFromIntToFloatWithScale < ActiveRecord::Migration[6.1]
  def down

    change_column :alcohols, :alcohol_percentage, :decimal, precision: 4,scale: 2
  end
  def up
    change_column :alcohols, :alcohol_percentage, :float, precision: 12, scale: 2
  end
end
