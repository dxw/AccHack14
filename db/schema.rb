# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141109100823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "homelessnesses", force: true do |t|
    t.integer  "local_authority_id"
    t.integer  "type_1"
    t.integer  "type_2"
    t.integer  "type_3"
    t.integer  "type_4"
    t.integer  "type_5"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_authorities", force: true do |t|
    t.string  "la_code"
    t.string  "name"
    t.string  "electoral_code"
    t.integer "total_households"
  end

  create_table "social_housing_sales", force: true do |t|
    t.integer "local_authority_id"
    t.integer "sales"
  end

  create_table "social_housings", force: true do |t|
    t.integer "person_council_rent",    default: 0
    t.integer "person_other_rent",      default: 0
    t.integer "person_total_rent",      default: 0
    t.string  "electoral_code"
    t.integer "household_council_rent"
    t.integer "household_other_rent"
    t.integer "household_total_rent"
    t.integer "local_authority_id"
  end

end
