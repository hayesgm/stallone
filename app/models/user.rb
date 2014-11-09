# Represents a user account in the system
# 
# auth_token:: 
# phone_number:: 
# uuid:: 
# public_key:: 
# private_key:: 
class User < ActiveRecord::Base

  # Relations
  has_many :spots

  # Validations
  validates :auth_token, :phone_number, :uuid, presence: true

  # Callbacks
  before_validation :set_auth_token, :set_uuid

  ### Member Functions

  def set_auth_token
    self.auth_token = SecureRandom.hex if self.auth_token.blank?
  end  

  def set_uuid
    self.uuid = SecureRandom.hex if self.uuid.blank?
  end

  def generate_keys!(passphrase)
    # Run some sanity checks
    raise "Passphrase blank!" if passphrase.blank?
    raise "Passphrase must be at least 6 characters, found `#{passphrase}`" if passphrase.length < 6
    raise "Already have keys set" if self.public_key.present? || self.private_key.present?

    rsa_key = OpenSSL::PKey::RSA.new(2048)
    cipher =  OpenSSL::Cipher::Cipher.new('des3')

    private_key = rsa_key.to_pem(cipher, passphrase)
    public_key = rsa_key.public_key.to_pem

    # Build the public and private keys
    self.update_attribute(:public_key, public_key)
    self.update_attribute(:private_key, private_key)
  end

  def encrypt(msg)
    raise "Missing public key" if public_key.blank?

    public_key = OpenSSL::PKey::RSA.new(self.public_key)
    
    # Return the encrypted string
    return Base64.encode64(public_key.public_encrypt(msg))
  end

  def decrypt(msg, passphrase)
    raise "Missing public key" if public_key.blank?
    raise "Missing private key" if private_key.blank?
    raise "Missing passphrase" if passphrase.blank?

    private_key = OpenSSL::PKey::RSA.new(self.public_key + self.private_key, passphrase)

    # Return the decrypted string
    return private_key.private_decrypt(Base64.decode64(msg))
  end

end
