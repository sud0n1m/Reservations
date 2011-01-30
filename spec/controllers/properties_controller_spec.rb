require 'spec_helper'

describe PropertiesController do
  render_views
  
  describe "GET 'show'" do
    before(:each) do
      @property = Factory(:property)
      #@user = Factory(:user)
    end
    
    it "should be successful" do
      #sign_in @user
      get :show, :id => @property
      response.should be_success
    end
    
    it "should find the right property" do
      get :show,  :id => @property
      assigns(:property).should == @property
    end
    
    it "should display the property name" do
      get :show, :id => @property
      response.should have_selector("h1", :content => @property.name )
    end
    
     it "should show the property's reservations" do
       @res3 = Factory(:reservation, :property => @property)
       #      res1 = Reservation.create!( :email => "colin@example.net", :from_date => Time.now + 5.days, :to_date => Time.now + 4.days, :property_id => "1" )
#      res2 = Reservation.create!( :email => "colin@example.net", :from_date => Time.now + 5.days, :to_date => Time.now + 4.days, :property_id => @property )
      get :show, :id => "1"
      response.should have_selector("td.email", :content => @res3.email)
 #      response.should have_selector("td.email", :content => res2.email)
     
     end
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Add a new property")
    end
  end
  
  describe "GET 'index'" do
    
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'index'
      response.should have_selector("title", :content => "All Properties")
    end
    
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :subdomain => ""}
      end
      
      it "should not create a property" do
        lambda do
          post :create, :user => @attr
        end.should_not change(Property, :count)
      end
      
      it "should display an error" do
          post :create, :user => @attr
          response.should have_selector("div", :id => "error_explanation")        
      end  
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :name => "New Property", :subdomain => "newproperty"}
      end
      
      it "should create a new property" do
        lambda do
          post :create, :property => @attr
        end.should change(Property, :count).by(1)
      end
      
      it "should redirect to the property show page" do
        post :create, :property => @attr
        response.should redirect_to(property_path(assigns(:property)))
      end
      
      it "should have a confirmation message" do
        post :create, :property => @attr
        flash[:success].should =~ /property added/i
      end
    end
  end
end
