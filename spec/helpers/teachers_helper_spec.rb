require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeachersHelper do
  include TeachersHelper

  describe "#link_to_teacher" do
    it "should return link to teacher with title as caption and other options" do
      t = mock_model Teacher, :id => 3, :name => "Name SecondName", :surname => "Surname"
      link_to_teacher( t, :class => "klass" ).should ==
        %{<a href="#{teacher_path(t)}" class="klass">Name SecondName Surname</a>}
    end
    it "should return nil given nil" do
      link_to_teacher( nil ).should == nil
    end
  end
end
