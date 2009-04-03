require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should not allow to change login" do
    u = Factory :user, :login => "first_login"
    lambda do
      u.update_attributes(:login => "modified_login")
    end.should_not change(u, :login)
  end
  
  describe "#last_forum_posts#of_topic" do
    before :each do
      @u1 = Factory :user
      @u2 = Factory :user
      @t1 = Factory :forum_topic
      @t2 = Factory :forum_topic
      @p11 = Factory :forum_post, :topic => @t1
      @p12 = Factory :forum_post, :topic => @t1
      @p21 = Factory :forum_post, :topic => @t2
      @p22 = Factory :forum_post, :topic => @t2
    end

    it "should return last viewed post only of given topic" do
      Factory :forum_topic_viewing, :user => @u1, :topic => @t1, :post => @p11
      Factory :forum_topic_viewing, :user => @u1, :topic => @t2, :post => @p22
      
      @u1.last_forum_posts.of_topic( @t1 ).should == @p11
      @u1.last_forum_posts.of_topic( @t2 ).should == @p22
    end

    it "should return last post viewed only by user it is called from" do
      Factory :forum_topic_viewing, :user => @u1, :topic => @t1, :post => @p11
      Factory :forum_topic_viewing, :user => @u2, :topic => @t1, :post => @p12
      
      @u1.last_forum_posts.of_topic( @t1 ).should == @p11
      @u2.last_forum_posts.of_topic( @t1 ).should == @p12
    end
  end
end
