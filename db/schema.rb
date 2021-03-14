# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_13_064138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basket_products", force: :cascade do |t|
    t.bigint "basket_id"
    t.bigint "product_id"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_basket_products_on_basket_id"
    t.index ["product_id"], name: "index_basket_products_on_product_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_baskets_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.decimal "age"
    t.string "gender"
    t.text "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ordered_products", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.string "product_name"
    t.decimal "product_price"
    t.string "product_color"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_ordered_products_on_order_id"
    t.index ["product_id"], name: "index_ordered_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.decimal "stock"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "basket_products", "baskets"
  add_foreign_key "basket_products", "products"
  add_foreign_key "baskets", "customers"
  add_foreign_key "ordered_products", "orders"
  add_foreign_key "ordered_products", "products"
  add_foreign_key "orders", "customers"
end
