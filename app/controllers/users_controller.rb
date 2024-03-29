class UsersController < ApplicationController

  before_filter :grab_user
  protect_from_forgery except: [:check, :initialize_keys, :add_spot, :add_spots]

  # Simple check to verify account works
  def check
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  # Initialize user keys
  def initialize_keys
    # First, check the keys aren't set
    raise SlyErrors::StateError, "User has already set keys" if @user.public_key.present? && @user.private_key.present?

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
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    speed = params[:speed].to_f
    course = params[:course].to_f
    timestamp = params[:timestamp].to_f # expect a float

    raise SlyErrors::ParameterError, "Missing latitude or longitude" if latitude.blank? || longitude.blank?

    message = {phone_number: @user.phone_number, latitude: latitude, longitude: longitude, speed: speed, course: course, timestamp: timestamp}.to_json

    encrypted_message, message_hash = @user.encrypt_and_sign(message)
    
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

  # Add multiple spots
  def add_spots

    spots = params[:spots]

    # Accept blank
    if spots.nil? || spots.blank? || spots.empty?
      respond_to do |format|
        format.json { render json: { success: true } }
      end

      return
    end

    raise SlyErrors::ParameterError, "Spots not an array" unless spots.is_a?(Array)

    spots.each do |spot|
      raise SlyErrors::ParameterError, "Spot is not a hash object" unless spot.is_a?(Hash)

      # We'll need to encrypt this message
      latitude = spot['latitude'].to_f
      longitude = spot['longitude'].to_f
      speed = spot['speed'].to_f
      course = spot['course'].to_f
      timestamp = spot['timestamp'].to_f # expect a float

      raise SlyErrors::ParameterError, "Missing latitude or longitude" if latitude.blank? || longitude.blank?

      message = {phone_number: @user.phone_number, latitude: latitude, longitude: longitude, speed: speed, course: course, timestamp: timestamp}.to_json

      encrypted_message, message_hash = @user.encrypt_and_sign(message)
      
      @user.spots.build(encrypted_message: encrypted_message, message_hash: message_hash)
    end

    if @user.save # builds all the spots
      respond_to do |format|
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @user.errors.full_messages } }
      end
    end
  end
end
