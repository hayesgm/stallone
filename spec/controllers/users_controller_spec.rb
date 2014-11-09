require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET check" do
    before { create(:user) }

    it "gets a good auth" do
      get :check, { auth_token: "validAuth", format: :json }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq({}.to_json)
    end

    it "rejects missing auth" do
      expect do
        get :check, { auth_token: "", format: :json }
      end.to raise_error(RuntimeError)
    end

    it "rejects bad auth" do
      expect do
        get :check, { auth_token: "wrongAuth", format: :json }
      end.to raise_error(RuntimeError)
    end
  end

  describe "GET initialize_keys" do
    before(:each) { @user = create(:user) }

    it "rejects when keys already initialized" do
      # Set the public and private key
      @user.update_attributes(private_key: 'a', public_key: 'b')

      expect do
        post :initialize_keys, { auth_token: "validAuth", format: 'json' }
      end.to raise_error(RuntimeError)
    end

    it "fails when given a too-short passphrase" do
      # TODO: These errors should be handled better
      expect do
        post :initialize_keys, { auth_token: "validAuth", passphrase: "bad", format: 'json' }
      end.to raise_error(RuntimeError)
    end

    # Do a valid key initiation
    it "returns http success" do
      # Big question of who should create the public and private key
      post :initialize_keys, { auth_token: "validAuth", passphrase: "good passphrase", format: 'json' }
      expect(response).to have_http_status(:success)

      json = JSON(response.body).with_indifferent_access

      # The end user only needs the public key and the auth token
      expect(json[:public_key]).to_not be_blank

      @user.reload

      expect(@user.public_key).to_not be_blank
      expect(@user.private_key).to_not be_blank
    end
  end

end
