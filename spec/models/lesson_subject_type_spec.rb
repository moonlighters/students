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
end
