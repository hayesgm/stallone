# Represents a user account in the system
# 
# auth_token:: 
# phone_number:: 
# uuid:: 
# public_key:: 
# private_key:: 
class User < ActiveRecord::Base

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

end
