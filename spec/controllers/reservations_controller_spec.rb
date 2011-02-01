require 'spec_helper'

describe ReservationsController do
  render_views

  describe "POST 'create'" do

    before(:each) do
      @property = Factory(:property)
      @attr = {   :email => "colin@blah.com", 
                  :from_date => Time.now + 5.days,
                  :to_date => Time.now + 6.days,
                  :property_id => "1" 
      }
    end

    describe "failure" do
      before(:each) do
        @attr.merge(:to_date => "")
      end

      it "should not create a reservation" do
        lambda do
          post :create, [@property, @reservation] => @attr
        end.should_not change(Reservation, :count)
      end
    
    end
    describe "success" do
      it "should create a reservation" do
        post :create, [:reservation] => @attr
        response.should be_success
      end
    end
  end
end
