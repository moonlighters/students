require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersHelper do
  include UsersHelper

  describe "link_to_user" do
    it "should return link to valid user with his nickname without options" do
      u = Factory :user
      link_to_user( u ).should == %{<a href="/users/#{u.id}">#{u.nickname}</a>}
    end

    it "should return link to valid user with content given in options" do
      u = Factory :user
      link_to_user( u, :content => "text" ).should == %{<a href="/users/#{u.id}">text</a>}
    end

    it "should return link to valid user with auxiliary options" do
      u = Factory :user
      link_to_user( u, :id => "cool_link" ).should == %{<a href="/users/#{u.id}" id="cool_link">#{u.nickname}</a>}
    end

    it "should raise error unless valid user" do
      lambda { link_to_user( nil ) }.should raise_error "Invalid user"
    end
  end
end
