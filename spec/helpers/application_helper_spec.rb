require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  include ApplicationHelper

  describe "#add_br_to_text" do
    it "should add a <br/> tag to every newline character in text" do
      add_br_to_text( "a\naaa\n\nd" ).should == "a<br/>\naaa<br/>\n<br/>\nd"
    end

    it "should not change text without newline characters" do
      ["aaa", "aa\taa", "", "bb\r"].each do |s|
        add_br_to_text( s ).should == s
      end
    end
  end

  describe "#flash_messages" do
    it "should generate empty array if there are no flashes" do
      flash_messages.should == []
    end
    
    it "should generate array with messages if there are not all flashes" do
      flash[:notice] = "NNotice"
      flash[:error] = "ERROR"
      fm = flash_messages
      fm[0].should =~ /NNotice/
      fm[1].should =~ /ERROR/
    end
    
    it "should generate array with messages if there are flashes" do
      flash[:notice] = "NNotice"
      flash[:warning] = "Warnin'"
      flash[:error] = "ERROR"
      fm = flash_messages
      fm[0].should =~ /NNotice/
      fm[1].should =~ /Warnin'/
      fm[2].should =~ /ERROR/
    end
  end

  describe "#format_time" do
    before do
      @time = Time.mktime 2009, 3, 14, 21, 9, 46 # The time of the first commit in our project :)
    end
    it "should return string with formatted time" do
      format_time( @time ).should == "21:09, 14 марта 2009"
    end
    it "should return string with formatted time without year" do
      format_time( @time, :year => false ).should == "21:09, 14 марта"
    end
    it "should return string with formatted time with month as digits" do
      format_time( @time, :month => :digits ).should == "21:09, 14.03.2009"
    end
    it "should return string with formatted time with month as digits and without year" do
      format_time( @time, :month => :digits, :year => false ).should == "21:09, 14.03"
    end
    it "should return string with formatted time without time" do
      format_time( @time, :time => false ).should == "14 марта 2009"
    end
    it "should return string with formatted time without date" do
      format_time( @time, :date => false ).should == "21:09"
    end
    it "should raise an exception given both :time and :date options false" do
      lambda { format_time @time, :time => false, :date => false }.should raise_error ArgumentError
    end
    it "should return string with formatted time in ansi format" do
      format_time( @time, :format => :ansi ).should == "2009-03-14 21:09"
    end
  end
  describe "#ansi_date" do
    it "should return date in ansi format" do
      time = Time.mktime 2009, 3, 14, 21, 9, 46 # The time of the first commit in our project :)
      ansi_date( time ).should == "2009-03-14"
    end
  end

  describe "String#downcase" do
    # powered by unicode gem
    it "should work for cyrillic" do
      ("абвъыьГДЕЭЮЯabcuvwDEFXYZ").downcase.should == "абвъыьгдеэюяabcuvwdefxyz"
    end
  end
end
