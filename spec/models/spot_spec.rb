require 'rails_helper'

RSpec.describe Spot, :type => :model do
  
  describe "given a user with spots" do
    let(:user) { build(:user) }
    let(:passphrase) { "abcdef" }

    before { user.generate_keys!(passphrase) }

    def build_spot(user, message)
      encrypted_message, message_hash = user.encrypt_and_sign(message)
      user.spots.create!(encrypted_message: encrypted_message, message_hash: message_hash)
    end

    it "should build a spot" do
      build_spot(user, "haha")
    end

    it "should be able to decypt itself" do
      spot = build_spot(user, "red dogs")

      expect(spot.decrypt(passphrase)).to eq("red dogs")
    end

    it "should build a spot and load" do
      spot = build_spot(user, '{"latitude": "cool"}')
      expect(spot).to receive("latitude=").once

      spot.decode!(passphrase)
    end

    it "should verify checksum on decode" do
      spot = build_spot(user, 'test')

      expect(spot.decypt_and_verify(passphrase)).to eq('test')
    end

    it "should verify checksum on decode" do
      spot = build_spot(user, 'test')
      spot.message_hash = "bad"

      expect { spot.decypt_and_verify(passphrase) }.to raise_error(SlyErrors::StateError)
    end
  end
end
