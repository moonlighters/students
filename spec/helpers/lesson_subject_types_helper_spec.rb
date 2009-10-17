require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonSubjectTypesHelper do
  include LessonSubjectTypesHelper

  describe "#link_to_subject_type" do
    before do
      @g = Factory :group, :name => "Group"
      @s = Factory :lesson_subject, :name => "Subject", :short_name => "Subj."
      @tp = Factory :lesson_type, :name => "Type"
      @tc = Factory :teacher, :name => "Teacher", :surname => "Teacheroff"
      @st = Factory :lesson_subject_type, :group => @g,
                                          :subject => @s,
                                          :lesson_type => @tp,
                                          :teacher => @tc
      @id = @st.id
    end
    it "should return nil given nil as subject_type" do
      link_to_subject_type(nil, true).should == nil
    end
    it "should return link to subject_type with default text given no params" do
      link_to_subject_type(@st, true).should == "<a href=\"/schedule/subject_types/#{@id}\">Тип занятия №#{@st.id}</a>"
    end
    it "should return link to subject_type with given fields' names listed" do
      link_to_subject_type(@st, true, :group, :lesson_type, :subject, :teacher).should ==
        %{<a href="/schedule/subject_types/#{@id}">Group, Type, Subject, Teacher</a>}
    end
    it "should return link to subject_type with only valid given fields' names listed" do
      link_to_subject_type(@st, true,  :group, :invalid_field, :subject, :too_invalid_field, :teacher).should ==
        %{<a href="/schedule/subject_types/#{@id}">Group, Subject, Teacher</a>}
    end
    it "should return link to subject_type with given fields' names listed as links" do
      link_to_subject_type(@st, false, :group, :lesson_type, :subject, :teacher).should ==
        %{в <a href="/groups/#{@g.id}">группе Group</a> } +
        %{<a href="/schedule/subject_types/#{@id}">Type</a> } +
        %{по <a href="/schedule/subjects/#{@s.id}">Subj.</a> } +
        %{ведёт <a href="/teachers/#{@id}">Teacher Teacheroff</a>}
    end
  end

end
