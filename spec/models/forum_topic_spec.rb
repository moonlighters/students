require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumTopic do
  it "should be valid given valid attributes" do
    Factory :forum_topic
  end
  
  it "should be valid given valid attributes without description" do
    Factory.build( :forum_topic, :description => nil ).should be_valid
  end

  [:title, :forum, :owner].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :forum_topic, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank title" do
    Factory.build( :forum_topic, :title => "  \t " ).should_not be_valid
  end

  it "should set view_count to 0 when created" do
    Factory.create( :forum_topic ).view_count.should == 0
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
  describe "#first_unread_post_of" do
    before :each do
      @u = Factory :user
      @t = Factory :forum_topic
      @p = Factory :forum_post, :topic => @t
      @t.view! @u
    end

    it "should return nil if user is nil" do
      @t.first_unread_post_of(nil).should be_nil
    end

    it "should return nil if there are no new posts" do
      @t.first_unread_post_of(@u).should be_nil
    end

    it "should return first unread post if there is any" do
      @p1 = Factory :forum_post, :topic => @t
      @p2 = Factory :forum_post, :topic => @t
      @t.first_unread_post_of(@u).should == @p1
    end

    it "should return first post of topic if topic is unviewed" do
      @t1 = Factory :forum_topic
      @p1 = Factory :forum_post, :topic => @t1
      @p2 = Factory :forum_post, :topic => @t1
      @t1.first_unread_post_of(@u).should == @p1
    end
  end

  describe "#last_post" do
    before do
      @t = Factory :forum_topic
      @p = Factory :forum_post, :topic => @t
    end
    it "should return last post in topic after its creation" do
      @t.last_post.should == @p
    end
    it "should return last post in topic after adding a new one" do
      @p1 = Factory :forum_post, :topic => @t
      @t.last_post.should == @p1
    end
    it "should return last post in topic after after deleting the last one" do
      @p1 = Factory :forum_post, :topic => @t
      @p1.destroy
      @t.last_post.should == @p
    end
  end
end
