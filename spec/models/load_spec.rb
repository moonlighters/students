require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Load do
  before do
    [Load, User].each( &:delete_all )
  end

  it "should be valid given valid attributes" do
    Factory :load
  end

  [:name, :owner, :file].each do |attr|
    it "should not be valid without #{attr}" do
      Factory.build( :load, attr => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank name" do
    Factory.build( :load, :name => "  \t  " ).should_not be_valid
  end

  it "should set :owner role to user" do
    user = Factory :user
    l = Factory :load, :owner => user
    user.has_role?( :owner, l).should be_true
  end

  describe "#owner" do
    it "should return owner of load" do
      user = Factory :user
      l = Factory :load, :owner => user
      l.owner == user
    end
  end

  describe "#owner?" do
    it "should return true if user is owner" do
      user = Factory :user
      l = Factory :load, :owner => user
      l.owner?( user ).should be_true
    end
    
    it "should return false if user isn't owner" do
      user = Factory :user
      another_user = Factory :user
      l = Factory :load, :owner => user
      l.owner?( another_user ).should be_false
    end
  end
end
