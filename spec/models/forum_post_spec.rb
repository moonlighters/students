require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumPost do
  it "should be valid given valid attributes" do
    Factory :forum_post
  end

  [:body, :topic, :owner].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :forum_post, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank body" do
    Factory.build( :forum_post, :body => " \n\n\n \t " ).should_not be_valid
  end
end
