require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GroupsHelper do
  include GroupsHelper

  describe "#link_to_group" do
    it "should return link to the given group" do
      g = Factory :group
      link_to_group( g ).should == "<a href=\"/groups/#{g.id}\">#{g.name}</a>"
    end
    it "should return nil given no group" do
      link_to_group( nil ).should == nil
    end
  end
end
