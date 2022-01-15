class RelationshipsDown < ActiveRecord::Migration[6.1]
  def change
    drop_table :relationships
  end
end
