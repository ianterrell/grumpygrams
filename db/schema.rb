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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100825222624) do

  create_table "gram_instances", :force => true do |t|
    t.string   "message"
    t.integer  "gram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipient_facebook_uid"
  end

  add_index "gram_instances", ["gram_id"], :name => "index_gram_instances_on_gram_id"

  create_table "grams", :force => true do |t|
    t.string   "name"
    t.string   "phrase"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position",           :default => 0
    t.string   "recipient_phrase"
    t.string   "facebook_tagline"
    t.string   "facebook_caption"
  end

  create_table "users", :force => true do |t|
    t.integer  "facebook_uid"
    t.string   "email"
    t.string   "facebook_username"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

end
