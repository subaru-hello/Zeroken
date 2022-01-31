class RemoveReferenceFromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :answers, :questions
    remove_index :answers, :question_id
    remove_reference :answers, :question
  end
end
