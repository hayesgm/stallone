class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def grab_user
    auth_token = params[:auth_token]

    raise "Missing auth" if auth_token.blank?

    @user = User.find_by_auth_token(auth_token.to_s)

    raise "Missing user" if @user.nil?
  end

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    User.find(session[:user_id]) if logged_in?
  end
end
