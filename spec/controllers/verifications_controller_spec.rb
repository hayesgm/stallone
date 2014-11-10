require 'rails_helper'

RSpec.describe VerificationsController, :type => :controller do

  describe "POST new" do
    it "returns http success" do

      # Expect we send an SMS to the auth number
      expect_any_instance_of(Twilio::REST::Messages).to receive(:create).once

      expect do
        post :new, { phone_number: '1112223333', format: 'json' }
        expect(response).to have_http_status(:success)
      end.to change{ Verification.count }.by(1)

      # Ensure we have a valid verification
      expect(Verification.last.phone_number).to eq('1112223333')
      expect(Verification.last.confirmation_token).to_not be_empty
    end
  end

  describe "POST confirm" do
    before { create(:verification) }

    it "returns http success when given correct code" do
      
      expect do
        post :confirm, { phone_number: '1112223333', confirmation_token: 'correctToken', format: 'json' }
        expect(response).to have_http_status(:success)
      end.to change{ User.count }.by(1)
      

      # We should have a new user account
      expect(User.last.phone_number).to eq('1112223333')
      expect(User.last.auth_token).to_not be_empty
      expect(User.last.uuid).to_not be_empty
      expect(User.last.public_key).to be_nil
      expect(User.last.private_key).to be_nil
    end

    it "returns http success when given incorrect code" do
      expect { post :confirm, { phone_number: '1112223333', confirmation_token: 'wrongToken', format: 'json' } }.to change{ User.count }.by(0)
      expect(response).to have_http_status(500)
    end

    it "allows new devices to connect to existing account" do
      user = User.create!(phone_number: '1112223333')
      user.update_attribute(:auth_token, 'haha')

      post :confirm, { phone_number: '1112223333', confirmation_token: 'correctToken', format: 'json' }
      expect(JSON(response.body)['auth_token']).to eq('haha')
    end
  end

end
