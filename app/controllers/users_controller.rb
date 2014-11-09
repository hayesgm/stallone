class UsersController < ApplicationController

  before_filter :grab_user
  protect_from_forgery except: [:check, :initialize_keys, :add_spot]

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
      format.json { render json: { success: true, public_key: @user.public_key } }
    end
  end

  # Add a spot
  def add_spot
    # We'll need to encrypt this message
    latitude = params[:latitude]
    longitude = params[:longitude]
    speed = params[:speed]
    course = params[:course]
    timestamp = params[:timestamp].to_f # expect a float

    raise "Missing lat/lon" if latitude.blank? || longitude.blank?

    message = {phone_number: @user.phone_number, latitude: latitude, longitude: longitude, speed: speed, course: course, timestamp: timestamp}.to_json

    encrypted_message = @user.encrypt(message)
    message_hash = Base64.encode64(Digest::SHA256.digest(message))

    p encrypted_message
    p message_hash

    @spot = @user.spots.new(encrypted_message: encrypted_message, message_hash: message_hash)

    if @spot.save
      respond_to do |format|
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @spot.errors.full_messages } }
      end
    end
  end
end
