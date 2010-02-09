# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100209202550) do

  create_table "grams", :force => true do |t|
    t.string   "name",       :limit => 64
    t.string   "slogan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_grams", :force => true do |t|
    t.string   "to_name",    :limit => 32
    t.string   "from_name",  :limit => 32
    t.string   "to_email"
    t.string   "from_email"
    t.string   "message"
    t.integer  "gram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end