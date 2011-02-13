require 'spec_helper'

describe Reservation do

  before(:each) do
    @property = Factory(:property)
    @attr = {
      :email => "colin@example.net",
      :from_date => Time.now + 25.days,
      :to_date => Time.now + 30.days,
    }
  end
  
  it "should create a new reservation given valid attributes" do
    @property.reservations.create!(@attr)
  end

  describe "property associations" do
    
    before(:each) do
      @reservation = @property.reservations.create!(@attr)
    end
    
    it "should have a property attribute" do
      @reservation.should respond_to(:property)
    end

    it "should have the right associated property" do
      @reservation.property_id.should == @property.id
      @reservation.property.should == @property
    end

  end

  describe "validations" do
    it "should require a property id" do
      Reservation.new(@attr).should_not be_valid
    end

    it "should not create a reservation if the property is reserved" do
      valid_res = @property.reservations.create(@attr)
      duplicate_res = @property.reservations.create(@attr)
      duplicate_res.should_not be_valid
    end

    it "should not prevent a reservation being created if another property is reserved" do
      @property2 = Factory(:property, :name => "Property 2", :subdomain => "property2")
      res1 = @property.reservations.create(@attr)
      res2 = @property2.reservations.create(@attr)
      res2.should be_valid
    end
    
    it "should not create a blank reservation" do
      blank_res = @property.reservations.create
      blank_res.should_not be_valid
    end
    
    it "should not create a reservation in the past" do
      @attr.merge!(:from_date => Time.now - 25.days)
      res = @property.reservations.create(@attr)
      res.should_not be_valid
    end
    
    it "should not create a reservation that ends before it begins" do
      @attr.merge!(:to_date => Time.now - 2.days)
      res = @property.reservations.create(@attr)
      res.should_not be_valid
    end
    

  end
  
end
