require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumTopic do
  it "should be valid given valid attributes" do
    Factory.build( :forum_topic ).should be_valid
  end
  
  it "should be valid given valid attributes without description" do
    Factory.build( :forum_topic, :description => nil ).should be_valid
  end

  [:title, :forum, :user].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :forum_topic, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with empty title" do
    Factory.build( :forum_topic, :title => "  \t " ).should_not be_valid
  end

  it "should set view_count to 0 when created" do
    Factory( :forum_topic ).view_count.should == 0
  end
end
