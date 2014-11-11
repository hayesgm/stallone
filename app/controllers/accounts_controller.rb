class AccountsController < ApplicationController

  before_filter :grab_user_from_session

  def home
    @spots = @user.spots.order("id desc").limit(50)
    @spots.each { |spot| spot.decode!(session[:passphrase]) }
  end

  private

  def grab_user_from_session
    return redirect_to root_path if session[:user_id].blank?

    @user = User.find(session[:user_id].to_i)
  end
end
