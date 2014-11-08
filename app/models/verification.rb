# Represents a Verification which a user can confirm to create account
#
# phone_number:: 
# confirmation_token:: 
class Verification < ActiveRecord::Base

  validates :phone_number, :confirmation_token, presence: true

  before_validation :set_confirmation_token

  ### Methods

  # Set confirmation token if otherwise blank
  def set_confirmation_token  
    self.confirmation_token = ( SecureRandom.random_number(10**5-10**4) + 10**4 ).to_s if self.confirmation_token.blank?
  end

  def send_sms!
    Twilio::REST::Client.new.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: self.phone_number,
      body: "Welcome to Stallone.  Your confirmation code is #{self.confirmation_token}."
    )
  end
end
