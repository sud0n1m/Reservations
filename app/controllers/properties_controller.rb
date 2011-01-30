class PropertiesController < ApplicationController
  #before_filter :authenticate_user!, :except => :book
  
  def show
    @property = Property.find(params[:id])
    @title = "#{@property.name}"
  end
  
  def book
    @property = Property.find_by_subdomain!(request.subdomain)
    @title = "Book #{@property.name}"
  end
  
  def new
    @property = Property.new
    @title = "Add a new property"
  end
  
  def index
    @title = "All Properties"
    @properties = Property.paginate(:page => params[:page])
  end
  
  def create
    @property = Property.new(params[:property])
    if @property.save
      flash[:success] = "Property Added"
      redirect_to @property
    else
      @title = "Add a new property"
      render 'new'
    end
  end
  
end
