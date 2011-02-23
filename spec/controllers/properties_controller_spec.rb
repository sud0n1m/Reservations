require 'spec_helper'

describe PropertiesController do
  render_views
  
  before(:each) do
    @attr = {:subdomain => "subdomain", :name => "propertyname"}
    @user = Factory(:user)
    @admin = Factory(:user, :admin => true, :email => "admin@example.com")
  end

  describe "GET 'show'" do
    before(:each) do
      sign_in @user
      @property = Factory(:property)
    end
    
    describe "for a normal user" do
      

      it "should be successful" do
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
      @res1 = Factory(:reservation, :email => "colin@example.net", 
                                    :from_date => Time.now + 4.weeks, 
                                    :to_date => Time.now + 5.weeks, 
                                    :property => @property)
      @res2 = Factory(:reservation, :email => "dave@example.com", 
                                    :from_date => Time.now + 6.weeks, 
                                    :to_date => Time.now + 7.weeks, 
                                    :property => @property)
      get :show, :id => @property 
      response.should have_selector("td.email", :content => @res1.email)
      response.should have_selector("td.email", :content => @res2.email)

     end
    end
    
    describe "for an admin user" do
      before(:each) do
        sign_in @admin
      end
      
      it "should be successful" do
        get :show, :id => @property
        response.should be_success
      end
      
      
    end
    
  end
  
  describe "GET 'new'" do
    
    describe "for non-admin users" do
      it "should deny access" do
        sign_in @user
        get :index
        response.should redirect_to(root_path)
        flash[:alert].should =~ /don't have access/i
      end
    end
    
     describe "for admin users" do
      before(:each) do
         sign_in @admin
      end
      
      it "should be successful" do
        get 'new'
        response.should be_success
      end
    
      it "should have the right title" do
        get 'new'
        response.should have_selector("title", :content => "Add a new property")
      end
    end
  end
  
  describe "GET 'index'" do

    describe "for non-admin users" do
      it "should deny access" do
        sign_in @user
        get :index
        response.should redirect_to(root_path)
        flash[:alert].should =~ /don't have access/i
      end
    end
    
    describe "for admin users" do
      before(:each) do
         sign_in @admin
      end
             
      it "should be successful" do
        get 'index'
        response.should be_success
      end

      it "should have the right title" do
        get 'index'
        response.should have_selector("title", :content => "All Properties")
      end
    end
    
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :subdomain => ""}
        sign_in @admin
      end
      
      it "should not create a property" do
        lambda do
          post :create, :property => @attr, :user_id => @user.id
        end.should_not change(Property, :count)
      end
      
      it "should display an error" do
          post :create, :property => @attr, :user_id => @user.id
          response.should have_selector("div", :id => "error_explanation")        
      end  
    end
    
    describe "success" do
      
      before(:each) do
        sign_in @admin
        @attr = { :name => "New Property", :subdomain => "newproperty"}
      end
      
      it "should create a new property" do
        lambda do
          post :create, :property => @attr, :user_id => @user.id
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
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @property = Factory(:property)
    end
    
    describe "as a non-signed in user" do
      it "should deny access" do
        delete :destroy, :id => @property
        response.should redirect_to(new_user_session_path)
      end
    end
    
    describe "as a non-admin user" do
      it "should protect the page" do
        sign_in @user
        delete :destroy, :id => @property
        response.should redirect_to(root_path)
        flash[:alert].should =~ /don't have access/i
      end
    end
    
    describe "as an admin user" do
      it "should destroy the property" do
        sign_in @admin
        lambda do
          delete :destroy, :id => @property.id
        end.should change(Property, :count).by(-1)
      end
    end
  end
  
  describe "validations" do
    before(:each) do
      sign_in @admin
    end
    it "should require a user id" do
      Property.new(@attr).should_not be_valid
    end
    
    it "should require non-blank subdomain" do
      @admin.properties.build(@attr.merge(:subdomain => "  ")).should_not be_valid
    end
    
  end
end
