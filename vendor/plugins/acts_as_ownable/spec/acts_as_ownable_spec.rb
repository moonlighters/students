require File.dirname(__FILE__) + '/spec_helper'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

# AR keeps printing annoying schema statements
$stdout = StringIO.new

class User < ActiveRecord::Base
  acts_as_authorization_subject
end

class Role < ActiveRecord::Base
  acts_as_authorization_role
end

class Ownable < ActiveRecord::Base
  acts_as_authorization_object
  acts_as_ownable
end

describe "acts_as_ownable" do
  before :all do
    ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

    ActiveRecord::Schema.define(:version => 1) do
      create_table "ownables" do |t|
        t.string   "name"
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

      create_table "users", :force => true do |t|
        t.string   "login"
      end
    end
  end

  it "should set :owner role to user" do
    user = Factory :user
    t = Factory :ownable, :owner => user
    user.has_role?( :owner, t).should be_true
  end

  describe "#owner" do
    it "should return owner of ownable" do
      user = Factory :user
      t = Factory :ownable, :owner => user
      t.owner.should == user
    end
  end

  describe "#owner?" do
    it "should return true if user is owner" do
      user = Factory :user
      t = Factory :ownable, :owner => user
      t.owner?( user ).should be_true
    end
    
    it "should return false if user isn't owner" do
      user = Factory :user
      another_user = Factory :user
      t = Factory :ownable, :owner => user
      t.owner?( another_user ).should be_false
    end
  end
end
