class AccountsController < ApplicationController

  before_filter :grab_user_from_session

  def home
    @page = (params[:page] || 0).to_i
    @per_page = 50

    @spots = @user.spots.order("id desc").limit(@per_page).offset(@page * @per_page)
    @spots.each { |spot| spot.decode!(session[:passphrase]) }
  end

  private

  def grab_user_from_session
    return redirect_to root_path if session[:user_id].blank?

    @user = User.find(session[:user_id].to_i)
  end
end
