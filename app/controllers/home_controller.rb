class HomeController < ApplicationController
  
  def home

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
