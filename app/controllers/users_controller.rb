class UsersController < ApplicationController

  before_filter :grab_user
  protect_from_forgery except: [:check, :initialize_keys]

  # Simple check to verify account works
  def check
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  # Initialize user keys
  def initialize_keys
    # First, check the keys aren't set
    raise "Already set keys" if @user.public_key.present? && @user.private_key.present?

    passphrase = params[:passphrase]

    # If so, generate the keys with a new RSA key
    @user.generate_keys!(passphrase)

    respond_to do |format|
      format.json { render json: { public_key: @user.public_key } }
    end
  end
end
