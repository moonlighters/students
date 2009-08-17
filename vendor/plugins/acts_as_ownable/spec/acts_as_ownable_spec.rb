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

  before do
    @user = Factory :user
    @another_user = Factory :user
    @o = Factory :ownable, :owner => @user
  end

  describe "owner=" do
    it "should set :owner role to user" do
      @user.has_role?( :owner, @o).should be_true
    end

    it "should unset previous owner" do
      #@o.update_attributes! :owner => @another_user
      @o.owner = @another_user
      @o.save!
      @user.has_role?( :owner, @o).should be_false
    end
  end

  describe "#owner" do
    it "should return owner of ownable" do
      @o.owner.should == @user
    end
  end

  describe "#owner?" do
    it "should return true if user is owner" do
      @o.owner?( @user ).should be_true
    end
    
    it "should return false if user isn't owner" do
      @o.owner?( @another_user ).should be_false
    end
  end
end
