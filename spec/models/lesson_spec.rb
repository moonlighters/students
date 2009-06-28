require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lesson do
  it "should be valid given valid attributes" do
    Factory.build( :lesson ).should be_valid
  end

  [:group_id, :subject_type, :day_of_week, :start_time, :duration].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :lesson, field => nil ).should_not be_valid
    end
  end

  [:term, :everyweek, :odd_weeks].each do |field|
    it "should be valid without #{field}" do
      Factory.build( :lesson, field => nil ).should be_valid
    end
  end

  describe "#set_start_time" do
    it "should set start_time" do
      l = Factory :lesson
      l.set_start_time 19, 30
      l.start_time.hour.should == 19
      l.start_time.min.should == 30
    end
  end
end
