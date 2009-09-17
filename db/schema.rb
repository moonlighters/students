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

ActiveRecord::Schema.define(:version => 20090917123727) do

  create_table "forum_posts", :force => true do |t|
    t.text     "body"
    t.integer  "forum_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_editor_id"
  end

  create_table "forum_topic_viewings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_topic_id"
    t.integer  "forum_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "view_count"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_post_id"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "start_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_subject_types", :force => true do |t|
    t.integer  "lesson_type_id"
    t.integer  "lesson_subject_id"
    t.integer  "group_id"
    t.integer  "teacher_id"
    t.string   "homepage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_subjects", :force => true do |t|
    t.string   "name"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "group_id"
    t.integer  "lesson_subject_type_id"
    t.integer  "term"
    t.integer  "day_of_week"
    t.datetime "start_time"
    t.integer  "duration"
    t.boolean  "everyweek"
    t.boolean  "odd_weeks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loads", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "download_counter",  :default => 0
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "authorizable_type"
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sexes", :force => true do |t|
    t.string "name"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sex_id"
  end

end
