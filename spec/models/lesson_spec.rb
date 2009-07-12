require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lesson do
  it "should be valid given valid attributes" do
    Factory :lesson
  end

  [:group_id, :subject_type, :day_of_week, :start_time, :duration, :term,].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :lesson, field => nil ).should_not be_valid
    end
  end

  [:everyweek, :odd_weeks].each do |field|
    it "should be valid without #{field}" do
      Factory :lesson, field => nil
    end
  end
  
  BEGIN_HOUR = Lesson::BEGIN_TIME[0]
  END_HOUR = Lesson::END_TIME[0]
  [BEGIN_HOUR-1, END_HOUR+1].each do |hour|
    it "should not be valid with start time #{hour} which is not between #{BEGIN_HOUR} and #{END_HOUR} hours" do
      # for correctness of this validation start_time must be set with #set_start_time method
      l = Factory :lesson
      l.set_start_time hour
      l.should_not be_valid
    end
  end

  it "should not be valid with end time after #{END_HOUR} hours" do
    # for correctness of this validation start_time must be set with #set_start_time method
    l = Factory :lesson
    l.set_start_time END_HOUR-1
    l.duration = 2.hours
    l.should_not be_valid
  end

  describe "#set_start_time" do
    it "should set start_time given hours and minutes" do
      l = Factory :lesson
      l.set_start_time 19, 30
      l.start_time.hour.should == 19
      l.start_time.min.should == 30
    end

    it "should set start_time given only hours" do
      l = Factory :lesson
      l.set_start_time 11
      l.start_time.hour.should == 11
      l.start_time.min.should == 0
    end
  end
end
