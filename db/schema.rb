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

ActiveRecord::Schema.define(version: 20170202231938) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "adverts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pet_id"
    t.integer  "advert_type"
    t.decimal  "price",                     precision: 10, scale: 2
    t.integer  "status"
    t.text     "comment",     limit: 65535
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "user_id"
    t.index ["pet_id"], name: "index_adverts_on_pet_id", using: :btree
    t.index ["user_id"], name: "index_adverts_on_user_id", using: :btree
  end

  create_table "avatars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.index ["imageable_type", "imageable_id"], name: "index_avatars_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "region_id"
    t.integer  "locality_type_id"
    t.string   "name_ru"
    t.string   "name_en"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["locality_type_id"], name: "index_cities_on_locality_type_id", using: :btree
    t.index ["region_id"], name: "index_cities_on_region_id", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_ru"
    t.string   "name_en"
    t.string   "iso"
    t.string   "iso3"
    t.string   "iso_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "like_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "favorite_id"
    t.integer "follower_id"
    t.index ["favorite_id"], name: "index_like_relationships_on_favorite_id", using: :btree
    t.index ["follower_id"], name: "index_like_relationships_on_follower_id", using: :btree
    t.index ["user_id"], name: "index_like_relationships_on_user_id", using: :btree
  end

  create_table "locality_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_en"
    t.string   "name_ru"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",        default: "#"
    t.string   "text"
    t.string   "icon"
    t.string   "class_name"
    t.integer  "kind"
    t.integer  "order_num"
    t.boolean  "visible",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "pet_birthdays", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pet_id"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_birthdays_on_pet_id", using: :btree
  end

  create_table "pets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id"
    t.string   "name"
    t.integer  "gender",                   default: 0
    t.integer  "weight"
    t.text     "about",      limit: 65535
    t.string   "home_name"
    t.integer  "family",                   default: 0
    t.index ["user_id"], name: "index_pets_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "country_id"
    t.integer  "locality_type_id"
    t.string   "name_ru"
    t.string   "name_en"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["country_id"], name: "index_regions_on_country_id", using: :btree
    t.index ["locality_type_id"], name: "index_regions_on_locality_type_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "last_name"
    t.string   "first_name"
    t.string   "patronymic"
    t.text     "about",                  limit: 65535
    t.boolean  "breeder"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "city_id"
    t.string   "phone"
    t.string   "site"
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
