class VerificationsController < ApplicationController

  protect_from_forgery except: [:new, :confirm]

  # This will create a new verification which we'll later confirm
  def new
    @verification = Verification.new(verification_params)

    if @verification.save
      @verification.send_sms!

      respond_to do |format|
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @verification.errors.full_messages }, status: 500 }
      end
    end
  end

  # This will confirm a verification and create a user account
  def confirm
    @verification = Verification.where(phone_number: params[:phone_number], confirmation_token: params[:confirmation_token]).first

    if @verification.nil?
      respond_to do |format|
        format.json { render json: { errors: "verification not found" }, status: 500 }
      end
    else

      # Should we associate with an existing user or make a new user?
      if User.where(phone_number: @verification.phone_number).exists?
        @user = User.find_by_phone_number(@verification.phone_number)

        respond_to do |format|
            format.json { render json: { success: true, auth_token: @user.auth_token } }
          end
      else

        # We have a verification; let's create a user account
        @user = User.new(phone_number: @verification.phone_number)

        if @user.save
          respond_to do |format|
            format.json { render json: { success: true, auth_token: @user.auth_token } }
          end
        else
          respond_to do |format|
            format.json { render json: { errors: @user.errors.full_messages }, status: 500 }
          end
        end
      end
    end
  end

  private

  def verification_params
    params.permit(:phone_number)
  end

end
