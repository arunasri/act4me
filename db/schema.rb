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

ActiveRecord::Schema.define(:version => 20110609212500) do

  create_table "jobs", :force => true do |t|
    t.integer  "number_of_requests"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "since_id"
  end

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.string   "cast"
    t.text     "plot"
    t.string   "director"
    t.string   "banner"
    t.string   "producer"
    t.string   "music_director"
    t.date     "released_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",            :default => true
    t.string   "last_computed_score"
    t.string   "horizontal"
    t.string   "vertical"
  end

  create_table "tweets", :force => true do |t|
    t.string   "from_user"
    t.string   "to_user"
    t.string   "profile_image_url"
    t.string   "text"
    t.string   "source"
    t.string   "metadata"
    t.integer  "twitter_id",         :limit => 8
    t.integer  "from_user_id",       :limit => 8
    t.integer  "to_user_id",         :limit => 8
    t.integer  "keyword_id"
    t.datetime "created_on_twitter"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movie_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
