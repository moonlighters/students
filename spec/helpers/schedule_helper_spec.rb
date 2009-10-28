require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ScheduleHelper do
  include ScheduleHelper

  describe "#week_caption" do
    before do
      @time = Time.mktime 2009, 6, 1  # Monday
    end
    it "should return '[date1] - [date2]'-like week caption with short year format" do
      week_caption(@time).should == " 1.06 -  7.06"
    end
    it "should return '[date1] - [date2]'-like week caption with long year format" do
      week_caption(@time, :long).should == " 1.06.2009 -  7.06.2009"
    end
  end

  describe "#link_to_schedule" do
    before do
      @g = Factory :group
      @t = Time.mktime 2009, 6, 1  # Monday
      @t_week = week_caption @t

      @t_ansi = ansi_date @t
      @t_text = format_time @t, :time => false, :year => false
    end
    it "should return link to today schedule given no params" do
      link_to_schedule.should == "<a href=\"/schedule/day\">На ближайший день</a>"
    end
    it "should return link to day schedule with given content" do
      link_to_schedule(@t, :day, :content => "content").should == "<a href=\"/schedule/day/#{@t_ansi}\">content</a>"
    end
    it "should return link to day schedule with given prefix and suffix" do
      link_to_schedule(@t, :day, :prefix => "pre", :suffix => "suf").should ==
        "<a href=\"/schedule/day/#{@t_ansi}\">pre#{@t_text}suf</a>"
    end
    it "should return link to day schedule for given day and group" do
      link_to_schedule(@t, :day, :content => "content", :group => @g).should ==
        "<a href=\"/schedule/group/#{@g.id}/day/#{@t_ansi}\">content</a>"
    end

    it "should return link to week schedule with default caption" do
      link_to_schedule(@t, :week).should == "<a href=\"/schedule/week/#{@t_ansi}\">#{@t_week}</a>"
    end
    it "should return link to week schedule with given caption, suffix, prefix and group" do
      link_to_schedule(@t, :week, :content => "content", :prefix => "<", :suffix => ">", :group => @g).should ==
        "<a href=\"/schedule/group/#{@g.id}/week/#{@t_ansi}\">&lt;content&gt;</a>"
    end
  end
  
  describe "#lessons_column" do
    before do
      @st = Factory :lesson_subject_type, :lesson_type => Factory( :lesson_type, :name => "лекция" )
      @lessons = [ Factory( :lesson, :duration => 1.hour, :subject_type => @st ), Factory( :lesson, :duration => 2.hours, :subject_type => @st ) ]
      @lessons[0].set_start_time Lesson::BEGIN_TIME[0] + 1, 0
      @lessons[1].set_start_time Lesson::BEGIN_TIME[0] + 2, 30
      
      @lessons[0].type.name.should == "лекция"

      @hour_height = 1.hour/Lesson::SECONDS_PER_PIXEL
      @int_height = Lesson::DURATION/Lesson::SECONDS_PER_PIXEL
      @break_height = Lesson::BREAK_DURATION/Lesson::SECONDS_PER_PIXEL
    end
    it "should return a formatted list of lesson intervals" do
      lessons_column( Lesson::INTERVALS[1..2], :class => "interval lesson-div" ).should == 
        %{<div class="interval lesson-div container" style="line-height: #{@int_height -2}px; margin-top: #{@int_height + @break_height -1}px; margin-bottom: 0px"><span class="block"><span></span></span><span class=\"iefix\">&nbsp;</span></div>}+
        %{<div class="interval lesson-div container" style="line-height: #{@int_height -2}px; margin-top: #{@break_height}px; margin-bottom: -1px"><span class="block"><span></span></span><span class=\"iefix\">&nbsp;</span></div>}
    end
    it "should return a formatted list of lessons" do
      ( lessons_column( @lessons, :apply_style => true ) {|l, i| i.to_s } ).should == 
        %{<div class="lektsiya container" style="line-height: #{@hour_height -2}px; margin-top: #{@hour_height -1}px; margin-bottom: 0px"><span class="block"><span>0</span></span><span class=\"iefix\">&nbsp;</span></div>}+
        %{<div class="lektsiya container" style="line-height: #{2*@hour_height -2}px; margin-top: #{@hour_height/2}px; margin-bottom: -1px"><span class="block"><span>1</span></span><span class=\"iefix\">&nbsp;</span></div>}
    end
    it "should not fail given nil as a collection" do
      lessons_column( nil ).should == ""
    end
  end
end
