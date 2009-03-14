class CreateRolesAndJoinTableWithUsers < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string   "name"
      t.string   "authorizable_type"
      t.integer  "authorizable_id" 

      t.timestamps
    end

    create_table "roles_users", :id => false do |t|
      t.integer  "user_id"
      t.integer  "role_id"

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
    drop_table :roles_users
  end
end
