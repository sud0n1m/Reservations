class PagesController < ApplicationController
  def home
    if current_user
      render 'properties#show'
    else
      @title = "Home"
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
