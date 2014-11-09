class AccountsController < ApplicationController

  before_filter :grab_user_from_session

  def home
    
  end

  def map

  end

  private

  def grab_user_from_session
    return redirect_to root_path if session[:user_id].blank?

    @user = User.find(session[:user_id].to_i)
  end
end
