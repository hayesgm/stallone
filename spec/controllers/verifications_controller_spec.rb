require 'rails_helper'

RSpec.describe VerificationsController, :type => :controller do

  describe "GET new" do
    it "returns http success" do

      # Expect we send an SMS to the auth number
      expect_any_instance_of(Twilio::REST::Messages).to receive(:create).once

      post :new, { number: '1112223333' }
      expect(response).to have_http_status(:success)

      # Ensure we have a valid verification
      expect(Verification.last.number).to eq('1112223333')
    end
  end

  describe "GET confirm" do
    it "returns http success when given correct code" do

      post :confirm, { number: '1112223333', confirmation: 'abcdef' }
      expect(response).to have_http_status(:success)
    end
  end

end
