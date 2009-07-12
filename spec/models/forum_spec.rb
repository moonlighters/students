require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Forum do
  it "should be valid given valid attributes" do
    Factory :forum
  end

  [:title, :description].each do |field|
    it "should not be valid without #{field}" do
      Factory.build( :forum, field => nil ).should_not be_valid
    end

    it "should not be valid with blank #{field}" do
      Factory.build( :forum, field => "  \t " ).should_not be_valid
    end
  end

  describe "should add children" do
    before do
      @f = Factory :forum
      @f1 = Factory :forum
      @f2 = Factory :forum
    end

    it "through #parent=" do
      @f1.parent = @f
      @f1.save
      @f2.parent = @f
      @f2.save
    end

    it "through #children<<" do
      @f.children << @f1 << @f2
    end

    after do
      @f.children.should == [@f1, @f2]
      [@f1, @f2].each {|x| x.parent.should == @f }
    end
  end
end
