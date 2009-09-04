require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Load do
  before do
    [Load, User].each( &:delete_all )
  end

  it "should be valid given valid attributes" do
    Factory :load
  end

  [:name, :owner, :file, :tag_list].each do |attr|
    it "should not be valid without #{attr}" do
      Factory.build( :load, attr => nil ).should_not be_valid
    end
  end

  it "should not be valid with blank name" do
    Factory.build( :load, :name => "  \t  " ).should_not be_valid
  end

  describe "when being deleted" do
    before do
      Load.delete_all
      Tag.delete_all
      Factory :load, :tag_list => "one"
    end

    it "should not delete tags which are used by others" do
      Factory( :load, :tag_list => "one" ).destroy
      Tag.find_by_name( "one" ).should_not be_nil
    end
    
    it "should delete tags which are not used by others" do
      a = Factory( :load, :tag_list => "two" ).destroy
      Tag.find_by_name( "two" ).should be_nil
    end
  end
end 
