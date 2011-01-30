require 'spec_helper'

describe Property do
  
  before(:each) do
    @attr = { :name => "Example Property", :subdomain => "example" }
  end
  
  it "should create a new instance given valid attributes" do
    Property.create!(@attr)
  end
  
  it "should require a name" do
    @attr.merge(:name => "")
    no_name_property = Property.new(@attr.merge(:name => ""))
    no_name_property.should_not be_valid
  end
  
  it "should require a subdomain" do
    @attr.merge(:subdomain => "")
    no_subdomain_property = Property.new(@attr.merge(:subdomain => ""))
    no_subdomain_property.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 61
    long_name_user = Property.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should reject subdomains that are duplicates" do
    dupe_subdomain = "EXAMPLE"
    property = Property.create!(@attr)
    dupe_property = Property.create(@attr.merge(:subdomain => dupe_subdomain))
    dupe_property.should_not be_valid
  end

  describe "reservation associations" do
    before(:each) do
      @property = Property.create(@attr)
    end

    it "should have a reservations attribute" do
      @property.should respond_to(:reservations)
    end
  end 

end
