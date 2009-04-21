require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonSubject do
  it "should be valid given valid attributes" do
    Factory.build( :lesson_subject ).should be_valid
  end

  [:name, :term].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :lesson_subject, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with empty name" do
    Factory.build( :lesson_subject, :name => "  \t " ).should_not be_valid
  end

  it "should not be valid with term <= 0" do
    Factory.build( :lesson_subject, :term => 0).should_not be_valid
    Factory.build( :lesson_subject, :term => -10).should_not be_valid
  end
  
end
