require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ForumsHelper do
  include ForumsHelper

  describe "#link_to_forum" do
    it "should return link to forum with title as caption and other options" do
      f = mock_model Forum, :id => 3, :title => "Coolest"
      link_to_forum( f, :class => "klass" ).should == %{<a href="/forums/3" class="klass">Coolest</a>}
    end

    it "should return link to forums index with other options if nil was given" do
      link_to_forum( nil, :class => "klass" ).should == %{<a href="/forums" class="klass">Форумы</a>}
    end
  end

  describe "#forum_path_formatted" do
    it "should generate path-like string to all ancestros of forum" do
      f0 = mock_model Forum, :id =>  1, :title => "Main"
      f1 = mock_model Forum, :id =>  9, :title => "First"
      f2 = mock_model Forum, :id => 27, :title => "Second"
      f3 = mock_model Forum, :id => 43, :title => "Third", :ancestors => [f2, f1, f0]
      forum_path_formatted( f3 ).should == 
        %{<a href="/forums">Форумы</a> > } +
        %{<a href="/forums/1">Main</a> > <a href="/forums/9">First</a> > } + 
        %{<a href="/forums/27">Second</a> > <a href="/forums/43">Third</a>}
    end

    it "should generate one link if forum is nil" do
      forum_path_formatted( nil ).should == 
        %{<a href="/forums">Форумы</a>}
    end
  end
    
end
