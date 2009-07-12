require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LessonType do
  it "should be valid given valid attributes" do
    Factory :lesson_type
  end

  it "should not be valid without name" do
    Factory.build( :lesson_type, :name => nil ).should_not be_valid
  end
end
