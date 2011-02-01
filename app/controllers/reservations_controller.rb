class ReservationsController < ApplicationController
  before_filter :find_property

  def show

  end

  def create
    Reservation.new
    @reservation = @property.reservations.build(params[:reservation])
    if @reservation.save
      redirect_to @property, flash => { :success => "Reservation created!" }
    else
      render 'properties/show' 
    end
  end
  
  def new

  end
  def index
    
  end

private

  def find_property
    @property = Property.find(params[:property_id])
  end
end
