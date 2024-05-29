# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_05_26_132919) do

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "party"
    t.integer "age"
    t.text "politic"
    t.integer "votes", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.timestamps
    # timestamps為migration預設欄位，會轉換成created_at與updated_id這兩個時間欄位
    # 在 資料新增 或 更新 的時候，自動寫入當下時間
  end

end
