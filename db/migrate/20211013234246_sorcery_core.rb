class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users , options: 'ROW_FORMAT=DYNAMIC' do |t|
      t.string :nickname, limit: 191
      t.string :email, null: false, limit: 191
      t.string :crypted_password, limit: 191
      t.string :salt, limit: 191
      t.integer :role, null: false, default: 1

      t.timestamps                null: false
    end
    add_index :users, :nickname, unique: true
    add_index :users, :email, unique: true
  end
end
