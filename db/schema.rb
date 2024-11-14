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

ActiveRecord::Schema[7.2].define(version: 2024_11_14_003344) do
  create_table "menu_items", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["product_id"], name: "index_menu_items_on_product_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portions", force: :cascade do |t|
    t.string "description"
    t.integer "price"
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_portions_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "calories"
    t.string "image"
    t.boolean "alcohol"
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "status", default: 0
    t.index ["restaurant_id"], name: "index_products_on_restaurant_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "cnpj"
    t.string "address"
    t.integer "phone_number"
    t.string "email"
    t.string "work_hours"
    t.string "code"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_taggings_on_product_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menu_items", "menus"
  add_foreign_key "menu_items", "products"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "portions", "products"
  add_foreign_key "products", "restaurants"
  add_foreign_key "products", "users"
  add_foreign_key "restaurants", "users"
  add_foreign_key "taggings", "products"
  add_foreign_key "taggings", "tags"
end
