class HomeController < ApplicationController
  
  def home
    redirect_to account_path if logged_in?
  end

  def done

  end

  def tos

  end

  def privacy
    
  end

  def stream
    @spots = Spot.all
  end

end
