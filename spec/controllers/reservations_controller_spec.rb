require 'spec_helper'

describe ReservationsController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @owner = Factory(:user)
      @property = Factory(:property, :user_id => @owner)
      @reservation = Factory(:reservation, :property_id => @property)
    end
    
    describe "for a user with the hash" do
      it "should show the reservation"
    end
    
    describe "for the property owner" do
      it "should show the reservation" do
        sign_in @owner
        get :show, :id => @reservation.id
        response.should be_success
      end
    end
      
    describe "for an admin" do
      it "should show the reservation"
    
    end
    
    describe "for an anonymous user" do
      it "should redirect to the site root" 
    end
    
    describe "for an unauthorized user" do
      it "should redirect to the site root"
      
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @property = Factory(:property)
      @attr = {   :email => "colin@blah.com", 
                  :from_date => Time.now + 5.days,
                  :to_date => Time.now + 6.days
      }
    end

    describe "failure" do
      before(:each) do
        @reservation = Factory.build(:reservation, :to_date => "", :property => @property)
      end

      it "should not create a reservation if there is no date" do
        lambda do
          post :create, :reservation => @reservation.attributes, :property_id => @property.id
        end.should_not change(Reservation, :count)
      end

      it "should not create a reservation if the dates are not free" do
        post :create, :reservation => @attr, :property_id => @property.id
        lambda do
         post :create, :reservation => @attr, :property_id => @property.id
        end.should_not change(Reservation, :count) 
      end
      
       it "should not create a reservation in the past" do
         @attr.merge!(:to_date => Time.now - 4.days)
        lambda do
         post :create, :reservation => @attr, :property_id => @property.id
        end.should_not change(Reservation, :count) 
       end
    end
    describe "success" do
      it "should create a reservation" do
        lambda do
          post :create, :reservation => @attr, :property_id => @property.id
        end.should change(Reservation, :count).by(1)
      end
    end
    
    
  end
  describe "DELETE 'destroy'" do
    before(:each) do
      @property = Factory(:property)
      @reservation = Factory(:reservation, :property_id => @property.id)
    end
    it "should delete the reservation" do
      lambda do
        delete :destroy, :id => @reservation, :property_id => @property
        flash[:success].should =~ /deleted/i
        response.should redirect_to(property_path)
      end.should change(Reservation, :count).by(-1)
        
    end
  end
end
