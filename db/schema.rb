# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_06_090309) do

  create_table "log_entries", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.string "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permission_groups", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
  end

  create_table "permissions", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "permission_group_id"
    t.string "name"
    t.string "mapping"
  end

  create_table "register_as", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "plate_number"
    t.boolean "customs", default: false
    t.decimal "cost", precision: 12, scale: 2
    t.decimal "net_stock", precision: 12, scale: 2
    t.decimal "net_customs", precision: 12, scale: 2
    t.decimal "net_transport", precision: 12, scale: 2
    t.decimal "gross", precision: 12, scale: 2
    t.integer "sender_id"
    t.integer "recipient_id"
    t.integer "carrier_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_bs", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "plate_number"
    t.boolean "customs", default: false
    t.decimal "cost", precision: 12, scale: 2
    t.decimal "net_stock", precision: 12, scale: 2
    t.decimal "net_customs", precision: 12, scale: 2
    t.decimal "net_transport", precision: 12, scale: 2
    t.decimal "gross", precision: 12, scale: 2
    t.integer "sender_id"
    t.integer "recipient_id"
    t.integer "carrier_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_cs", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "plate_number"
    t.string "operation"
    t.boolean "customs", default: false
    t.decimal "cost", precision: 12, scale: 2
    t.decimal "net_stock", precision: 12, scale: 2
    t.decimal "net_customs", precision: 12, scale: 2
    t.decimal "net_transport", precision: 12, scale: 2
    t.decimal "gross", precision: 12, scale: 2
    t.integer "sender_id"
    t.integer "recipient_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_ds", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "timeframe"
    t.string "operation_type"
    t.string "cadence"
    t.decimal "cost", precision: 12, scale: 2
    t.decimal "net", precision: 12, scale: 2
    t.decimal "gross", precision: 12, scale: 2
    t.integer "sender_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_es", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.string "plate_number"
    t.string "container"
    t.decimal "gross", precision: 12, scale: 2
    t.decimal "nole_cost", precision: 12, scale: 2
    t.decimal "bl_cost", precision: 12, scale: 2
    t.decimal "transport_cost", precision: 12, scale: 2
    t.decimal "stop_cost", precision: 12, scale: 2
    t.decimal "incidental_cost", precision: 12, scale: 2
    t.decimal "net", precision: 12, scale: 2
    t.decimal "weight", precision: 12, scale: 2, default: "0.0"
    t.integer "packages"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.integer "carrier_id"
    t.integer "vendor_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_permissions", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "admin", default: false
  end

  create_table "user_roles", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "login", limit: 40
    t.string "name", limit: 100, default: ""
    t.string "email", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "sender", default: false
    t.boolean "recipient", default: false
    t.boolean "carrier", default: false
    t.boolean "vendor", default: false
    t.boolean "register_a", default: false
    t.boolean "register_b", default: false
    t.boolean "register_c", default: false
    t.boolean "register_d", default: false
    t.boolean "register_e", default: false
  end

end
