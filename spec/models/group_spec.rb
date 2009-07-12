require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Group do
  it "should be valid given valid attributes" do
    Factory :group
  end

  [:name, :start_year].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :group, field => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank name" do
    Factory.build( :group, :name => "  \t " ).should_not be_valid
  end

  it "should not be valid with start_year equal to 1900" do
    Factory.build( :group, :start_year => 1900).should_not be_valid
  end

  it "should not be valid with start_year equal to now + 10" do
    Factory.build( :group, :start_year => Time.now.year + 10).should_not be_valid
  end
  
end
