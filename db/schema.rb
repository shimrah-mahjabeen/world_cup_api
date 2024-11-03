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

ActiveRecord::Schema[7.0].define(version: 2024_10_31_204246) do
  create_table "countries", force: :cascade do |t|
    t.string "team", null: false
    t.string "team_code", limit: 3, null: false
    t.string "associated_with", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_score", default: 0, null: false
    t.integer "home_penalty", default: 0
    t.integer "away_score", default: 0, null: false
    t.integer "away_penalty", default: 0
    t.integer "attendance"
    t.string "venue", null: false
    t.string "round", null: false
    t.date "date", null: false
    t.string "hosts", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_country_id", null: false
    t.integer "away_country_id", null: false
    t.index ["away_country_id"], name: "index_matches_on_away_country_id"
    t.index ["home_country_id", "away_country_id", "date", "round"], name: "index_unique_match", unique: true
    t.index ["home_country_id"], name: "index_matches_on_home_country_id"
    t.check_constraint "round IN ('Final', 'Semi-finals', 'Third-place match', 'Quarter-finals', 'Round of 16', 'Group stage')"
  end

  add_foreign_key "matches", "countries", column: "away_country_id"
  add_foreign_key "matches", "countries", column: "home_country_id"
end
