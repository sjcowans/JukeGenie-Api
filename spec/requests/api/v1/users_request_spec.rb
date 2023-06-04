require 'rails_helper'

describe "Users API" do
  describe "GET /api/v1/users/:id" do
    it "sends a User within a key of data" do
      
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", role: "1", spotify_id: "fasidfuasfd", confirm_token: "oojidjfaosdf")
  
      get "/api/v1/users/#{user.id}"
      
      parsed_user = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      expect(parsed_user[:data]).to have_key(:id)
      expect(parsed_user[:data][:id]).to be_a(String)

      expect(parsed_user[:data]).to have_key(:type)
      expect(parsed_user[:data][:type]).to be_a(String)
      expect(parsed_user[:data][:type]).to eq("user")

      expect(parsed_user[:data]).to have_key(:attributes)
      expect(parsed_user[:data][:attributes]).to be_a(Hash)

      expect(parsed_user[:data][:attributes]).to have_key(:username)
      expect(parsed_user[:data][:attributes][:username]).to be_a(String)

      expect(parsed_user[:data][:attributes]).to have_key(:email)
      expect(parsed_user[:data][:attributes][:email]).to be_a(String)

      expect(parsed_user[:data][:attributes]).to have_key(:token)
      expect(parsed_user[:data][:attributes][:token]).to be_a(String)

      expect(parsed_user[:data][:attributes]).to have_key(:role)
      expect(parsed_user[:data][:attributes][:role]).to be_a(String)

      expect(parsed_user[:data][:attributes]).to have_key(:spotify_id)
      expect(parsed_user[:data][:attributes][:spotify_id]).to be_a(String)

      expect(parsed_user[:data][:attributes]).to have_key(:email_confirmed)
      expect(parsed_user[:data][:attributes][:email_confirmed]).to be_a(FalseClass)

      expect(parsed_user[:data][:attributes]).to have_key(:confirm_token)
      expect(parsed_user[:data][:attributes][:confirm_token]).to be_a(String)
    end

    it "if input ID is not in database, error is sent" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", role: "1", spotify_id: "fasidfuasfd", confirm_token: "oojidjfaosdf")

      get "/api/v1/users/#{user.id}023423"

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Couldn't find User with 'id'=#{user.id}023423"
                }
            ]
        }
          )
    end
  end
end