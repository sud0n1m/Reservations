class PropertiesController < ApplicationController
  before_filter :authenticate_user!, :except => [:book, :create]
  
  def show
    @property = Property.find(params[:id])
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
  
end
