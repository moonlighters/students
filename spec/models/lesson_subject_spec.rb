require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonSubject do
  it "should be valid given valid attributes" do
    Factory :lesson_subject
  end

  [:name, :short_name, :term].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :lesson_subject, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank name" do
    Factory.build( :lesson_subject, :name => "  \t " ).should_not be_valid
  end

  [0, -10].each do |i|
    it "should not be valid with term equal to #{i}" do
      Factory.build( :lesson_subject, :term => i).should_not be_valid
    end
  end
  
end
