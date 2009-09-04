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
      l = Factory.build :lesson
      l.set_start_time hour
      l.should_not be_valid
    end
  end

  it "should not be valid with end time after #{END_HOUR} hours" do
    # for correctness of this validation start_time must be set with #set_start_time method
    l = Factory.build :lesson
    l.set_start_time END_HOUR-1
    l.duration = 2.hours
    l.should_not be_valid
  end

  describe "crossing checking: lesson" do
    # for correctness of this validation start_time must be set with #set_start_time method
    before do
      @g = Factory :group
      @l1 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g
      @l1.set_start_time 10, 0
      @l1.save!
    end
    
    it "should not be valid when its end crosses another lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g 
      l2.set_start_time 9, 30
      l2.should_not be_valid
    end
    it "should not be valid when its beginning crosses another lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g 
      l2.set_start_time 10, 30
      l2.should_not be_valid
    end
    it "should not be valid when its time is inside another lesson's time" do
      l2 = Factory.build :lesson, :duration => 30.minutes, :group => @g 
      l2.set_start_time 10, 30
      l2.should_not be_valid
    end
    it "should not be valid when another lesson's time is inside its time" do
      l2 = Factory.build :lesson, :duration => 3.hours, :group => @g
      l2.set_start_time 9, 30
      l2.should_not be_valid
    end
    it "should not be valid when its time equals to another lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g
      l2.set_start_time 10, 0
      l2.should_not be_valid
    end
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
  
  describe "#lessons_for" do
    it "should return lessons for given group, term and day_of_week" do
      g1 = Factory :group
      g2 = Factory :group
      l1 = Factory :lesson, :group => g1, :term => 1, :day_of_week => 5
      l2 = Factory :lesson, :group => g2, :term => 2, :day_of_week => 2

      Lesson.lessons_for( g1, 1, 5 ).should == [l1]
    end
  end
end
