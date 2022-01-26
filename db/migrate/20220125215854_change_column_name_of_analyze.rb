class ChangeColumnNameOfAnalyze < ActiveRecord::Migration[6.1]
  def change
    rename_column :tast_answers,  :face_flush,:selected_choices_0
      rename_column :tast_answers, :other_than_face_flush,:selected_choices_1
      rename_column :tast_answers, :itchy,:selected_choices_2
      rename_column :tast_answers, :dizy,:selected_choices_3
      rename_column :tast_answers, :drowsy,:selected_choices_4
      rename_column :tast_answers, :anxiety,:selected_choices_5
      rename_column :tast_answers, :headache,:selected_choices_6
      rename_column :tast_answers, :throbbing_headache,:selected_choices7
      rename_column :tast_answers, :sweating,:selected_choices_8
      rename_column :tast_answers, :heartbeating,:selected_choices_9
      rename_column :tast_answers, :nauseous,:selected_choices_10
      rename_column :tast_answers, :chill,:selected_choices_11
      rename_column :tast_answers, :breathless,:selected_choices_12
  end
end
