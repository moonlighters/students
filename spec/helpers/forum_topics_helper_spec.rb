require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumTopicsHelper do
  include ForumTopicsHelper
  
  describe "#link_to_topic" do
    it "should return link to topic with title as caption and other options" do
      t = mock_model ForumTopic, :id => 3, :title => "Coolest"
      link_to_topic( t, :class => "klass" ).should == %{<a href="/forums/topics/3" class="klass">Coolest</a>}
    end
  end
  
end
