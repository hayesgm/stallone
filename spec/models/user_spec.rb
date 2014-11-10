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

    context "when verifying a password" do
      before { user.generate_keys!("ballon1") }

      it "should verify correct passphrase" do
        expect(user.is_correct_passphrase?("ballon1")).to be true
      end

      ["blue","dog house","balloon11","",nil,0,true,false].each do |exp|  
        it "should reject `#{exp}`" do
          expect(user.is_correct_passphrase?(exp)).to be false
        end
      end
    end

  end
end
