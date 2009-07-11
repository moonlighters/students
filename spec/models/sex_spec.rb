require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sex do
  it "should have 3 records" do
    Sex.all.count.should == 3
  end
  
  it "should have male, female and undefined records" do
    Sex.male.name.should == "мужской"
    Sex.female.name.should == "женский"
    Sex.undefined.name.should == "не определился"
  end

  ["мужской", "другой", "", "   \t "].each do |s|
    it "should not create new records with name '#{s}'" do
      Sex.create( :name => s ).should_not be_valid
    end
  end
end
