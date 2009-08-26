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
  describe "#term" do
    it "should return an odd term if given date is from September to December" do
      term( Time.mktime(2007, 10, 10), 2007 ).should == 1
      term( Time.mktime(2009, 9, 9), 2007 ).should == 5
    end
    it "should return an odd term if given date is in January" do
      term( Time.mktime(2008, 1, 1), 2007 ).should == 1
      term( Time.mktime(2009, 1, 9), 2007 ).should == 3
    end
    it "should return an even term if given date is from February to August" do
      term( Time.mktime(2008, 2, 1), 2007 ).should == 2
      term( Time.mktime(2010, 5, 9), 2007 ).should == 6
    end
    it "should raise an exception if given date is earlier then studying start" do
      lambda { term( Time.mktime(2007, 2, 1), 2007 ) }.should raise_error ArgumentError
      lambda { term( Time.mktime(2005, 9, 1), 2007 ) }.should raise_error ArgumentError
    end
  end
end
