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

ActiveRecord::Schema.define(:version => 20090711143653) do

  create_table "forum_posts", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
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
    t.integer  "user_id"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "parent_id"
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
