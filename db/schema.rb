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

ActiveRecord::Schema.define(version: 20170817030053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commodities", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "commodity_type_id"
    t.string   "bar_code"
    t.string   "specification"
    t.string   "unit"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.decimal  "cost",              precision: 8, scale: 2
    t.decimal  "sale",              precision: 8, scale: 2
    t.integer  "low_stock"
    t.integer  "high_stock"
    t.index ["high_stock"], name: "index_commodities_on_high_stock", using: :btree
    t.index ["low_stock"], name: "index_commodities_on_low_stock", using: :btree
    t.index ["name"], name: "index_commodities_on_name", using: :btree
  end

  create_table "commodity_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_commodity_types_on_name", using: :btree
  end

  create_table "commodity_warehouse_relationships", force: :cascade do |t|
    t.integer  "commodity_id"
    t.integer  "warehouse_id"
    t.integer  "stock_quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["commodity_id"], name: "index_commodity_warehouse_relationships_on_commodity_id", using: :btree
    t.index ["warehouse_id"], name: "index_commodity_warehouse_relationships_on_warehouse_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "number"
    t.integer  "stock_type_id"
    t.integer  "warehouse_id"
    t.datetime "d_date"
    t.integer  "staff_id"
    t.text     "summary"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["number"], name: "index_documents_on_number", using: :btree
    t.index ["stock_type_id"], name: "index_documents_on_stock_type_id", using: :btree
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "gender",     default: 1
    t.string   "telephone"
    t.string   "address"
    t.integer  "status",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_staffs_on_name", using: :btree
  end

  create_table "stock_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "s_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "code"
    t.integer  "commodity_id"
    t.integer  "stock_type_id"
    t.integer  "warehouse_id"
    t.decimal  "price",         precision: 8, scale: 2, default: "0.0"
    t.integer  "quantity"
    t.decimal  "sum",           precision: 8, scale: 2, default: "0.0"
    t.text     "summary"
    t.datetime "s_date"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "document_id"
    t.index ["document_id"], name: "index_stocks_on_document_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "location"
    t.string   "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_warehouses_on_name", using: :btree
  end

end
