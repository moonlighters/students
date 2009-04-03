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
  
  describe "#view!" do
    before :each do
      @u = Factory :user
      @t = Factory :forum_topic
      @p = Factory :forum_post, :topic => @t
    end

    it "should increment viewing_count" do
      v = @t.view_count
      @t.view! @u 
      @t.view_count.should == v + 1
    end

    it "should create new ForumTopicViewing record if topic is not read yet" do
      @t.view! @u
      @u.last_forum_posts.of_topic( @t ).should == @p
    end

    it "should modify existing ForumTopicViewing record" do
      @t.view! @u
      @p1 = Factory :forum_post, :topic => @t
      @t.view! @u
      ForumTopicViewing.count( :conditions => ["user_id = ? and forum_topic_id = ?", @u.id, @t.id] ).should == 1
      @u.last_forum_posts.of_topic( @t ).should == @p1
    end

    it "should not add ForumTopicViewing records if not logged in" do
      ForumTopicViewing.delete_all
      @t.view! nil
      ForumTopicViewing.all.should == []
    end
  end
end
