class PropertiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user, :except => :show
  before_filter :valid_user, :only => :show
  
  def show
    @user = current_user
    unless params[:id] != nil
      @property = @user.properties.first
    else
      @property = Property.find(params[:id])
    end
    @title = "#{@property.name}"
    @reservation = Reservation.new
  end
  
  def new
    @property = Property.new
    @title = "Add a new property"
  end
  
  def index
    @title = "All Properties"
    @properties = Property.page(params[:page])
  end
  
  def create
    @user = current_user
    @property = @user.properties.build(params[:property])
    if @property.save
      redirect_to @property, :flash => { :success => "Property added" }
    else
      @title = "Add a new property"
      render 'new'
    end    
  end
  
  def destroy
    Property.find(params[:id]).destroy
    flash[:success] = "Property removed."
    redirect_to properties_path
  end
  
  private
  
  def admin_user
    redirect_to root_path, :flash => { :alert => "You don't have access to that" } unless current_user.admin? 
  end
  
  def valid_user
    @user = current_user
    unless params[:id] != nil
      @property = @user.properties.first
    else
      @property = Property.find(params[:id])
    end
    unless @user = @property.user || @user.admin?
      redirect_to root_path, :flash => { :alert => "You don't have access to that" }
    end
  end
end
