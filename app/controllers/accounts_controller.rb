class AccountsController < ApplicationController

  before_filter :grab_user_from_session

  def home
    @page = (params[:page] || 0).to_i
    @date = grab_date || Date.today

    @spots = @user.spots.order("id desc").where("created_at > :begin AND created_at <= :end", begin: @date.beginning_of_day, end: @date.end_of_day)
    @spots.each { |spot| spot.decode!(session[:passphrase]) }
  end

  private

  def grab_user_from_session
    return redirect_to root_path if session[:user_id].blank?

    @user = User.find(session[:user_id].to_i)
  end

  def grab_date
    # Check each is available
    %w{day month year}.each { |s| return nil if params[s.to_sym].blank? }

    return DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, 0, 0, 0, Time.zone.utc_offset)
  end

end
