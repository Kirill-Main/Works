# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_201_212_204_314) do
  create_table 'idioms', force: :cascade do |t|
    t.string 'str_from'
    t.string 'language_from'
    t.string 'str_to'
    t.string 'language_to'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'middles', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'idiom_id', null: false
    t.boolean 'is_active', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['idiom_id'], name: 'index_middles_on_idiom_id'
    t.index ['user_id'], name: 'index_middles_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'name'
    t.string 'password'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'middles', 'idioms'
  add_foreign_key 'middles', 'users'
end
