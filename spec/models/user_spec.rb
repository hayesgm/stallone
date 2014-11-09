require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "verify keys work" do
    let(:user) { create(:user) }

    it "should generate keys" do
      user.generate_keys!("test word")

      expect(user.public_key).to_not be_empty
      expect(user.private_key).to_not be_empty
    end

    it "should allow encrpytion and decryption" do
      pass = "test pass"
      msg = "some data"

      user.generate_keys!(pass)

      # Encrypt should exist on the client, not us
      encrypted_message = user.encrypt(msg)
      
      # Make sure we've actually done some encryption
      expect(encrypted_message.include?(msg)).to be false

      # Now, cehck to see if we can decrypt correctly
      expect(user.decrypt(encrypted_message, pass)).to eq(msg)
    end

  end
end
