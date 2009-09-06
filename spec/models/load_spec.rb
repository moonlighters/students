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

  describe ".paginate_tagged_with" do
    before do
      @tag_sets = %w{ a a,b b,c,d c a,c,d b,a,d,c f,c }.reverse
      @loads = @tag_sets.map { |tags| Factory :load, :tag_list => tags }
      @l = @loads.reverse
    end

    it "should return last loads given no tag" do
      Load.paginate_tagged_with( [], :page => 1, :per_page => 3).should == @loads.reverse[0..2]
      Load.paginate_tagged_with( [], :page => 2, :per_page => 3).should == @loads.reverse[3..5]
    end
    it "should return last loads filtered by given one tag" do
      tag = Tag.find_by_name! "a"
      Load.paginate_tagged_with( [tag], :page => 1, :per_page => 3).should == [@l[0], @l[1], @l[4]]
      Load.paginate_tagged_with( [tag], :page => 2, :per_page => 3).should == [@l[5]]
    end
    it "should return last loads given filtered by multiple tags" do
      tags = [Tag.find_by_name!( "b" ),
              Tag.find_by_name!( "c" ),
              Tag.find_by_name!( "d" )]
      Load.paginate_tagged_with( tags, :page => 1, :per_page => 1).should == [@l[2]]
      Load.paginate_tagged_with( tags, :page => 2, :per_page => 1).should == [@l[5]]
    end
  end
end 
