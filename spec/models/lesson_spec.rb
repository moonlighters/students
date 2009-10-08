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

      @l_odd = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g, :everyweek => false, :odd_weeks => true
      @l_odd.set_start_time 15, 0
      @l_odd.save!
    end
    
    it "should be valid when its time doesn't cross another lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g
      l2.set_start_time 12, 0
      l2.should be_valid
    end
    it "should be valid when its time crosses only another-week lesson's time" do
      l_even = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g, :everyweek => false, :odd_weeks => false
      l_even.set_start_time 15, 0
      l_even.should be_valid
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

    it "should not be valid when it's an everyweek one and its time crosses any not-everyweek lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g
      l2.set_start_time 15, 0
      l2.should_not be_valid
    end
    it "should not be valid when it's a not-everyweek one and its time crosses any everyweek lesson's time" do
      l2 = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g, :everyweek => false, :odd_weeks => false
      l2.set_start_time 10, 0
      l2.should_not be_valid
    end
    it "should not be valid when it's a not-everyweek one and its time crosses a same-week lesson's time" do
      l_even = Factory.build :lesson, :duration => 1.hour + 35.minutes, :group => @g, :everyweek => false, :odd_weeks => true
      l_even.set_start_time 15, 0
      l_even.should_not be_valid
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
  
  describe ".lessons_for" do
    before do
      @g1 = Factory :group
      @g2 = Factory :group
      @g_fake = Factory :group # This one has no schedule

      @l1 = Factory :lesson, :group => @g1, :term => 1, :day_of_week => 5
      @l2 = Factory :lesson, :group => @g2, :term => 2, :day_of_week => 2

      @l3 = Factory :lesson, :group => @g1, :term => 2, :day_of_week => 3, :everyweek => false, :odd_weeks => true
      @l4 = Factory :lesson, :group => @g1, :term => 2, :day_of_week => 3, :everyweek => false, :odd_weeks => false
    end
    it "should return lessons for given group, term and day_of_week" do
      Lesson.lessons_for( @g1, 1, 5, :both ).should == [@l1]
    end
    it "should return lessons for given group, term and day_of_week and both odd and even weeks" do
      Lesson.lessons_for( @g1, 2, 3, :both ).should == [@l3, @l4]
    end
    it "should return lessons for given group, term and day_of_week and odd weeks" do
      Lesson.lessons_for( @g1, 2, 3, true ).should == [@l3]
    end
    it "should return lessons for given group, term and day_of_week and even weeks" do
      Lesson.lessons_for( @g1, 2, 3, false ).should == [@l4]
    end
    it "should return an empty array, if there's no lessons for given group, term and day_of_week and even weeks" do
      Lesson.lessons_for( @g1, 2, 6, false ).should == []
    end
    it "should return nil, if there's no schedule for given group and term at all" do
      Lesson.lessons_for( @g_fake, 2, 3, false ).should == nil
    end
  end
  describe ".term" do
    it "should return value for examinations if given date is in January or June" do
      Lesson.term( Time.mktime(2008, 1, 1), 2007 ).should == Lesson::NO_TERM_EXAMINATIONS
      Lesson.term( Time.mktime(2008, 2, 1), 2007 ).should == Lesson::NO_TERM_EXAMINATIONS
      Lesson.term( Time.mktime(2009, 6, 9), 2007 ).should == Lesson::NO_TERM_EXAMINATIONS
    end
    it "should return an even Lesson.term if given date is from February to May" do
      Lesson.term( Time.mktime(2008, 2, 11), 2007 ).should == 2
      Lesson.term( Time.mktime(2010, 5, 9), 2007 ).should == 6
    end
    it "should return value for vacation if given date is from July to August" do
      Lesson.term( Time.mktime(2008, 7, 1), 2007 ).should == Lesson::NO_TERM_VACATION
      Lesson.term( Time.mktime(2009, 8, 9), 2007 ).should == Lesson::NO_TERM_VACATION
    end
    it "should return an odd Lesson.term if given date is from September to December" do
      Lesson.term( Time.mktime(2007, 10, 10), 2007 ).should == 1
      Lesson.term( Time.mktime(2009, 9, 9), 2007 ).should == 5
    end
    it "should raise an exception if given date is earlier then studying start" do
      lambda { Lesson.term( Time.mktime(2007, 2, 1), 2007 ) }.should raise_error ArgumentError
      lambda { Lesson.term( Time.mktime(2005, 9, 1), 2007 ) }.should raise_error ArgumentError
    end
  end

  describe ".odd_week?" do
    it "should return true if given date falls on an odd week in the odd term" do
      Lesson.odd_week?( Time.mktime 2009, 9, 3).should == true
      Lesson.odd_week?( Time.mktime 2002, 9, 8).should == true # In 2002, 1'st September falls on Sunday, and first week starts on 2'nd
    end
    it "should return true if given date falls on an odd week in the even term" do
      Lesson.odd_week?( Time.mktime 2009, 2, 15).should == true
      Lesson.odd_week?( Time.mktime 2003, 2, 16).should == true # In 2003, 9'th February falls on Sunday, and first week starts on 10'th
    end
    it "should return false if given date falls on an even week in the odd term" do
      Lesson.odd_week?( Time.mktime 2009, 9, 13).should == false
      Lesson.odd_week?( Time.mktime 2002, 9, 15).should == false # In 2002, 1'st September falls on Sunday, and first week starts on 2'nd
    end
    it "should return false if given date falls on an even week in the odd term" do
      Lesson.odd_week?( Time.mktime 2009, 2, 16).should == false
      Lesson.odd_week?( Time.mktime 2003, 2, 17).should == false # In 2003, 9'th February falls on Sunday, and first week starts on 10'th
    end
  end
end
