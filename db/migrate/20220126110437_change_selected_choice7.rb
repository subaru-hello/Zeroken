class ChangeSelectedChoice7 < ActiveRecord::Migration[6.1]
  def change
    rename_column :tast_answers, :selected_choices7, :selected_choices_7
  end
end
