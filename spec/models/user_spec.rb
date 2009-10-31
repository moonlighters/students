require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should not allow to change login" do
    u = Factory :user, :login => "first_login"
    lambda do
      u.update_attributes(:login => "modified_login")
    end.should_not change(u, :login)
  end

  it "should be valid given valid attributes" do
    Factory :user
  end
end
