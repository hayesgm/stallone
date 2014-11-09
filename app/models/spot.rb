# An encrypted location peice for a user
# 
# user_id:: 
# encrypted_message:: 
# message_hash:: 
class Spot < ActiveRecord::Base

  # Transient attributes
  attr_accessor :phone_number, :latitude, :longitude, :speed, :course, :timestamp

  # Associations
  belongs_to :user

  # Validations
  validates :user_id, :encrypted_message, :message_hash, presence: true

  ### Member Functions

  # TODO: Test
  def decrypt(passphrase)
    self.user.decrypt(self.encrypted_message, passphrase)
  end

  def decode(passphrase)
    JSON(decrypt(passphrase)).each do |k,v|
      self.send("#{k}=", v)
    end
  end

  # TODO: Test
  def decypted_and_verify(passphrase)
    decrypted_message = decrypt(passphrase)

    expected = Digest::SHA256.digest(decrypted_message)
    raise "Failed SHA-256 checksum" if expected != Base64.decode64(message_hash)
  end

end
