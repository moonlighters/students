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
end
