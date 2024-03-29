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

ActiveRecord::Schema.define(:version => 20100601161716) do

  create_table "comments", :force => true do |t|
    t.text     "body",                  :null => false
    t.integer  "user_id"
    t.integer  "documentation_page_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentation_pages", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "content",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "position"
    t.text     "toc"
  end

  add_index "documentation_pages", ["parent_id", "position"], :name => "documentation_pages_parent_id_position_key", :unique => true

  create_table "site_configs", :force => true do |t|
    t.string   "site_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "use_document_author_list", :default => false
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              :default => false, :null => false
    t.string   "displayname",         :default => "",    :null => false
    t.boolean  "admin",               :default => false, :null => false
    t.boolean  "moderator",           :default => false
    t.boolean  "document_author",     :default => false, :null => false
  end

end
