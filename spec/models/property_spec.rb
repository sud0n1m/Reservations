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

  describe "availability checks" do
    before(:each) do
      @property = Property.create(@attr)
      @res =  Reservation.create!( :email => "colin1@example.net", :from_date => Time.now + 10.days, :to_date => Time.now + 14.days, :property_id => @property )
      @date = Time.now + 11.days

    end
    
    it "should have an available? method" do
      @property.should respond_to(:available?)
    end
    
    it "should not be available if there is a reservation" do
      @property.available?(@date).should_not be_true
    end
    
    it "should be available if there is no reservation" do
      @property.available?(@date + 6.days).should be_true
    end
    
  end


  describe "reservation associations" do
    before(:each) do
      @property = Property.create(@attr)
      @res2 = Reservation.create!( :email => "colin@example.net", :from_date => Time.now + 5.days, :to_date => Time.now + 7.days, :property_id => @property )
      @res1 =  Reservation.create!( :email => "colin1@example.net", :from_date => Time.now + 10.days, :to_date => Time.now + 14.days, :property_id => @property )

    end

    it "should have a reservations attribute" do
      @property.should respond_to(:reservations)
    end

    it "should have the right reservations in the right order" do
      @property.reservations.should == [@res1, @res2]
    
    end

    it "should destroy associated reservations" do
      @property.destroy
      [@res1, @res2].each do |reservation|
        Reservation.find_by_id(reservation.id).should be_nil
      end
    
    end
  end 

end
