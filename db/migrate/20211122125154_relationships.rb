class Relationships < ActiveRecord::Migration[6.1]
  def change
    create_table "relationships", force: :cascade do |t|
      t.integer "liquor_box_id", null: false
      t.integer "liquor_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["liquor_id"], name: "index_relationships_on_liquor_id"
      t.index ["liquor_box_id"], name: "index_relationships_on_liquor_box_id"
    end
  end
end
