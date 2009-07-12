require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Teacher do
  it "should be valid given valid attributes" do
    Factory :teacher
  end

  [:name, :surname].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :teacher, field => nil ).should_not be_valid
    end

    it "should not be valid with blank #{field}" do
      Factory.build( :teacher, field => "  \t " ).should_not be_valid
    end
  end

  [:phone, :email].each do |field|
    it "should be valid without #{field}" do
      Factory :teacher, field => nil
    end
  end

  %w{+0(000)000-00-00   8(123)456-78-910   (123)4545
     12-12-12   01    +7-923-000000    +12345}.each do |ph|
    it "shoud be valid with correct phone #{ph}" do
      Factory :teacher, :phone => ph
    end
  end
  
  %w{000abc  +34+  +(000)00  0()000  0(000
     +00)00  000--00  0000- -0000}.each do |ph|
    it "should not be valid with incorrect phone #{ph}" do
      Factory.build( :teacher, :phone => ph).should_not be_valid
    end
  end

end
