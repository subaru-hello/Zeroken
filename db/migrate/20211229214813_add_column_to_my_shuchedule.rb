class AddColumnToMyShuchedule < ActiveRecord::Migration[6.1]
  def change
    remove_column :my_shuchedules, :succeed_result, :integer
    add_column :my_shuchedules, :succeed_shuchedule, :integer
    add_column :my_shuchedules, :succeed_alcohol_strongness, :integer, default: 0
  end
end
