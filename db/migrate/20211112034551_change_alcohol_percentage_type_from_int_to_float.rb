class ChangeAlcoholPercentageTypeFromIntToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :alcohols, :alcohol_percentage, :float
  end
end
