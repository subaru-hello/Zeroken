class ChangeNextNomivationTypesToNextMotivation < ActiveRecord::Migration[6.1]
  def change
    remove_column :analyzes, :next_nomivation_types, :string
    add_column :analyzes, :next_motivation, :string
  end
end
