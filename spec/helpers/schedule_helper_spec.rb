require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ScheduleHelper do
  include ScheduleHelper

  describe "#link_to_day_schedule" do
    it "should return link to day schedule given no params" do
      link_to_day_schedule.should == "<a href=\"/schedule/day\">" + format_time( Time.now, :time => false ) + "</a>"
    end
    it "should return link to day schedule with given content" do
      link_to_day_schedule(nil, nil, :content => "content").should == "<a href=\"/schedule/day\">content</a>"
    end
    it "should return link to day schedule with given prefix and suffix" do
      link_to_day_schedule(nil, nil, :prefix => "pre",
                                     :suffix => "suf").should == "<a href=\"/schedule/day\">pre" + format_time( Time.now, :time => false ) + "suf</a>"
    end
    it "should return link to day schedule for given day and group" do
      g = Factory :group
      t = Time.mktime 2004, 3, 1
      link_to_day_schedule(t, g, :content => "content").should == "<a href=\"/schedule/day/2004-03-01?group_id=#{g.id}\">content</a>"
    end
  end
  
  describe "#lessons_column" do
    before do
      @lessons = [ Factory( :lesson, :duration => 1.hour ), Factory( :lesson, :duration => 2.hours ) ]
      @lessons[0].set_start_time Lesson::BEGIN_TIME[0] + 1, 0
      @lessons[1].set_start_time Lesson::BEGIN_TIME[0] + 2, 30

      @hour_height = 1.hour/Lesson::SECONDS_PER_PIXEL
      @int_height = Lesson::DURATION/Lesson::SECONDS_PER_PIXEL
      @break_height = Lesson::BREAK_DURATION/Lesson::SECONDS_PER_PIXEL
    end
    it "should return a formatted list of lesson intervals" do
      lessons_column( Lesson::INTERVALS[1..2] ).should == 
        "<div class=\"lesson-div\" style=\"height: #{@int_height -2}px; margin-top: #{@int_height + @break_height}px;\"><table><td></td></table></div>"+
        "<div class=\"lesson-div\" style=\"height: #{@int_height -2}px; margin-top: #{@break_height}px;\"><table><td></td></table></div>"
    end
    it "should return a formatted list of lessons" do
      ( lessons_column( @lessons ) {|l, i| i.to_s } ).should == 
        "<div class=\"lesson-div\" style=\"height: #{@hour_height -2}px; margin-top: #{@hour_height}px;\"><table><td>0</td></table></div>"+
        "<div class=\"lesson-div\" style=\"height: #{2*@hour_height -2}px; margin-top: #{@hour_height/2}px;\"><table><td>1</td></table></div>"
    end
  end
end
