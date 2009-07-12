require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumTopicViewing do
  it "should be valid given valid attributes" do
    Factory :forum_topic_viewing
  end
  
  [:topic, :post, :user].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :forum_topic_viewing, field => nil ).should_not be_valid
    end
  end
end
