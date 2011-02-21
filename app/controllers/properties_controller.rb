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
