require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should not allow to change nickname" do
    u = Factory :user, :nickname => "first_nickname"
    lambda do
      u.update_attributes(:nickname => "modified_nickname")
    end.should_not change(u, :nickname)
  end

  it "should be valid given valid attributes" do
    Factory :user
  end
end
