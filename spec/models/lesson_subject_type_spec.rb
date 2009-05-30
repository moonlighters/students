require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonSubjectType do
  it "should be valid given valid attributes" do
    Factory.build( :lesson_subject_type ).should be_valid
  end

  [:lesson_type, :subject, :group, :teacher].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :lesson_subject_type, field => nil ).should_not be_valid
    end
  end

  it "should be valid without homepage" do
    Factory.build( :lesson_subject_type, :homepage => nil ).should be_valid
  end

  describe "#types_in_group" do
    it "should return existing lesson_types for given group" do
      t1 = Factory :lesson_type, :name => "first"
      t2 = Factory :lesson_type, :name => "second"
      s = Factory :lesson_subject
      g1 = Factory :group, :name => "AFTI"
      g2 = Factory :group, :name => "FTI"
      Factory :lesson_subject_type, :group => g1, :lesson_type => t1, :subject => s
      Factory :lesson_subject_type, :group => g2, :lesson_type => t2, :subject => s

      s.types_in_group( g1 ).should == [t1]
      s.types_in_group( g2 ).should == [t2]
    end
  end

  describe "#process_homepage_url" do
    it "should add http:// to an url without it" do
      st = Factory :lesson_subject_type, :homepage => "ya.ru"
      st.process_homepage_url
      st.homepage.should == "http://ya.ru"
    end
    it "should not add http:// to an url with it" do
      st = Factory :lesson_subject_type, :homepage => "http://ya.ru"
      st.process_homepage_url
      st.homepage.should == "http://ya.ru"
    end
    it "should not add http:// to an empty homepage" do
      st = Factory :lesson_subject_type, :homepage => ""
      st.process_homepage_url
      st.homepage.should == ""
    end
    it "should remove http:// if there is no address then" do
      st = Factory :lesson_subject_type, :homepage => "http://"
      st.process_homepage_url
      st.homepage.should == ""
    end
  end
end
