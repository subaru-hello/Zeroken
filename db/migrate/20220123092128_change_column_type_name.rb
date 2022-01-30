class ChangeColumnTypeName < ActiveRecord::Migration[6.1]
  def change
    change_column :answers, :point, :decimal,  precision: 12, scale: 4
  end
end
