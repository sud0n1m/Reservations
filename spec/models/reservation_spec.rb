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
  
end
