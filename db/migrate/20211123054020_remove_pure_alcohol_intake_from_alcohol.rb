class RemovePureAlcoholIntakeFromAlcohol < ActiveRecord::Migration[6.1]
  def change
    remove_column :alcohols, :pure_alcohol_intake, :integer
  end
end
