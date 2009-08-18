require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Load do
  before do
    [Load, User].each( &:delete_all )
  end

  it "should be valid given valid attributes" do
    Factory :load
  end

  [:name, :owner, :file].each do |attr|
    it "should not be valid without #{attr}" do
      Factory.build( :load, attr => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank name" do
    Factory.build( :load, :name => "  \t  " ).should_not be_valid
  end
end
