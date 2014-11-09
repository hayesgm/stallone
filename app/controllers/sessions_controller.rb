class SessionsController < ApplicationController
  
  # Login page
  def new
    
  end

  # Submit login
  def create
    reset_session # destroy any old session info

    user = User.find_by_phone_number(params[:phone_number])

    if user && user.verify(params[:passphrase])
      
      session[:user_id] = user.id
      session[:passphrase] = params[:passphrase]

      return redirect_to account_path
    end

    # Failed login
    flash[:errors] = "Invalid phone number or passphrase."
    render :new
  end

  # Logout from your account
  def logout
    reset_session
    redirect_to root_path, flash: "You have been logged out"
  end
end
