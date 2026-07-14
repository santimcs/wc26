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

ActiveRecord::Schema.define(version: 20260708094120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.string "logo"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "criteria", force: :cascade do |t|
    t.date "show_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixtures", force: :cascade do |t|
    t.bigint "round_id"
    t.date "date"
    t.bigint "session_id"
    t.bigint "home_team_id"
    t.bigint "away_team_id"
    t.bigint "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "criterium_id"
    t.bigint "next_match_id"
    t.string "winner_slot"
    t.index ["away_team_id"], name: "index_fixtures_on_away_team_id"
    t.index ["channel_id"], name: "index_fixtures_on_channel_id"
    t.index ["criterium_id"], name: "index_fixtures_on_criterium_id"
    t.index ["home_team_id"], name: "index_fixtures_on_home_team_id"
    t.index ["next_match_id"], name: "index_fixtures_on_next_match_id"
    t.index ["round_id"], name: "index_fixtures_on_round_id"
    t.index ["session_id"], name: "index_fixtures_on_session_id"
  end

  create_table "knockout_teams", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "group_letter", limit: 1, null: false
    t.integer "position", null: false
    t.integer "seed_rank"
    t.integer "bracket_slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bracket_slot"], name: "index_knockout_teams_on_bracket_slot", unique: true
    t.index ["team_id", "group_letter"], name: "index_knockout_teams_on_team_id_and_group_letter", unique: true
    t.index ["team_id"], name: "index_knockout_teams_on_team_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "fixture_id"
    t.integer "home_goals"
    t.integer "away_goals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_penalties"
    t.integer "away_penalties"
    t.index ["fixture_id"], name: "index_results_on_fixture_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "sequence"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "sequence"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standings", force: :cascade do |t|
    t.bigint "team_id"
    t.integer "played", default: 0
    t.integer "wins", default: 0
    t.integer "draws", default: 0
    t.integer "losses", default: 0
    t.integer "goals_for", default: 0
    t.integer "goals_against", default: 0
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "form"
    t.index ["team_id"], name: "index_standings_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.integer "ranking"
    t.string "flag"
    t.string "confederation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fixtures", "channels"
  add_foreign_key "fixtures", "criteria"
  add_foreign_key "fixtures", "fixtures", column: "next_match_id"
  add_foreign_key "fixtures", "rounds"
  add_foreign_key "fixtures", "sessions"
  add_foreign_key "fixtures", "teams", column: "away_team_id"
  add_foreign_key "fixtures", "teams", column: "home_team_id"
  add_foreign_key "knockout_teams", "teams"
  add_foreign_key "results", "fixtures"
  add_foreign_key "standings", "teams"
end
