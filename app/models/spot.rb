# An encrypted location peice for a user
# 
# user_id:: 
# encrypted_message:: 
# message_hash:: 
class Spot < ActiveRecord::Base

  # Transient attributes
  attr_accessor :phone_number, :latitude, :longitude, :speed, :course, :timestamp, :time_in_zone

  # Associations
  belongs_to :user

  # Validations
  validates :user_id, :encrypted_message, :message_hash, presence: true

  ### Member Functions

  # Decypts this spot's message
  def decrypt(passphrase)
    self.user.decrypt(self.encrypted_message, passphrase)
  end

  # Decrypts this spot's message, and verifies its checksum matches expectation
  def decypt_and_verify(passphrase)
    decrypted_message = decrypt(passphrase)

    expected = Digest::SHA256.digest(decrypted_message)
    raise SlyErrors::StateError, "Failed SHA-256 checksum" unless expected == Base64.decode64(message_hash)

    decrypted_message
  end

  # Decrypts the message and loads it into transient attributes
  def decode!(passphrase)
    JSON(decrypt(passphrase)).each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def timestamp=(time)
    @timestamp = time
    @time_in_zone = Time.zone.at(time)
  end

end
