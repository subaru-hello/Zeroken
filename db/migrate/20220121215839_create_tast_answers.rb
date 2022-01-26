class CreateTastAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :tast_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer  :face_flush
      t.integer :other_than_face_flush
      t.integer :itchy
      t.integer :dizy
      t.integer :drowsy
      t.integer :anxiety
      t.integer :headache
      t.integer :throbbing_headache
      t.integer :sweating
      t.integer :heartbeating
      t.integer :nauseous
      t.integer :chill
      t.integer :breathless

      t.timestamps
    end
  end
end
