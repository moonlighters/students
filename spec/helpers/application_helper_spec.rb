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

  describe "flash_messages" do
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
end
