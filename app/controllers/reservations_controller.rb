class ReservationsController < ApplicationController
  before_filter :get_property
  
  def show

  end

  def create
    Reservation.new
    @reservation = @property.reservations.build(params[:reservation])
    if @reservation.save
      redirect_to @property, flash => { :success => "Reservation created!" }
    else
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      render "new"
    end
  end
  
  def new
    @title = "Book #{@property.name}"
    @reservation = Reservation.new
    @bookings = @property.reservations
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    render :layout => 'booking'
  end
  
  def index
    
  end
  
  def destroy
    @property = Property.find(params[:property_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to property_path(:id => params[:property_id]), :flash => { :success => "Reservation deleted" }
    else
      redirect_to property_path(:id => params[:property_id]), :flash => { :error => "Whoops. We couldn't delete the reservation"}
    end
  end
  
  private
  
  def get_property
    @property = Property.find_by_subdomain(request.subdomain) || Property.find_by_id(params[:property_id])
  end
end
