class VerificationsController < ApplicationController

  # This will create a new verification which we'll later confirm
  def new
    @verification = Verification.new(verification_params)

    if @verification.save
      @verification.send_sms!

      respond_to do |format|
        format.json { render json: {} }
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

      # We have a verification; let's create a user account
      # TODO: Are we going to allow other auths?
      @user = User.new(phone_number: @verification.phone_number)

      if @user.save
        respond_to do |format|
          format.json { render json: { auth_token: @user.auth_token } }
        end
      else
        respond_to do |format|
          format.json { render json: { errors: @user.errors.full_messages }, status: 500 }
        end
      end

    end
  end

  private

  def verification_params
    params.permit(:phone_number)
  end

end
