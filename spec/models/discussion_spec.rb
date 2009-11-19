require 'spec_helper'

describe Discussion do
  it "should be valid given valid attributes" do
    Factory :discussion
  end
  it "should not be valid without message" do
    Factory.build( :discussion, :message => "" ).should_not be_valid
  end
end
