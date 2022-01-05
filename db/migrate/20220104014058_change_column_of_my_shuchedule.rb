class ChangeColumnOfMyShuchedule < ActiveRecord::Migration[6.1]
  def change
    remove_column :my_shuchedules, :succeed_alcohol_strongness, :integer, default: 0
    add_column :my_shuchedules, :succeed_alcohol_strongness, :integer
  end
end
