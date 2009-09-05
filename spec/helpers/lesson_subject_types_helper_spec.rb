require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonSubjectTypesHelper do
  include LessonSubjectTypesHelper

  describe "#link_to_subject_type" do
    before do
      @g = Factory :group, :name => "Group"
      @s = Factory :lesson_subject, :name => "Subject"
      @tp = Factory :lesson_type, :name => "Type"
      @tc = Factory :teacher, :name => "Teacher"
      @st = Factory :lesson_subject_type, :group => @g,
                                          :subject => @s,
                                          :lesson_type => @tp,
                                          :teacher => @tc
    end
    it "should return nil given nil as subject_type" do
      link_to_subject_type(nil).should == nil
    end
    it "should return link to subject_type with default text given no params" do
      link_to_subject_type(@st).should == "<a href=\"/schedule/subject_types/#{@st.id}\">Тип занятия №#{@st.id}</a>"
    end
    it "should return link to subject_type with given fields' names listed" do
      link_to_subject_type(@st, :group, :lesson_type, :subject, :teacher).should ==
        "<a href=\"/schedule/subject_types/1\">Group, Type, Subject, Teacher</a>"
    end
    it "should return link to subject_type with only valid given fields' names listed" do
      link_to_subject_type(@st, :group, :invalid_field, :subject, :too_invalid_field, :teacher).should ==
        "<a href=\"/schedule/subject_types/1\">Group, Subject, Teacher</a>"
    end
  end

end
