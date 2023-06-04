require 'rails_helper'

describe "Users API" do
  describe "GET /api/v1/users/:id" do
    it "sends a User within a key of data" do
      
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", role: "1", spotify_id: "fasidfuasfd")
  
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
    end

    it "if input ID is not in database, error is sent" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", role: "1", spotify_id: "fasidfuasfd")

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


  describe "POST /api/v1/users" do
    it "is passed attributes required as JSON and creates a new user" do
      user_params = ({
        "username": "Buzzy Bees",
        "email": "bee@bee.com",
        "token": "wdjnfaipsdfuapsiodfjnaks30930952",
        "role": "0",
        "spotify_id": "sadfo30d93209234",
        "confirm_token": "2309ijfoif23nafs0ioj0"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)


      created_user = User.last

      created_user_formatted = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
  
      expect(created_user_formatted[:data]).to have_key(:id)
      expect(created_user_formatted[:data][:id]).to be_a(String)

      expect(created_user_formatted[:data]).to have_key(:type)
      expect(created_user_formatted[:data][:type]).to be_a(String)
      expect(created_user_formatted[:data][:type]).to eq("user")

      expect(created_user_formatted[:data]).to have_key(:attributes)
      expect(created_user_formatted[:data][:attributes]).to be_a(Hash)

      expect(created_user_formatted[:data][:attributes]).to have_key(:username)
      expect(created_user_formatted[:data][:attributes][:username]).to be_a(String)

      expect(created_user_formatted[:data][:attributes]).to have_key(:email)
      expect(created_user_formatted[:data][:attributes][:email]).to be_a(String)

      expect(created_user_formatted[:data][:attributes]).to have_key(:token)
      expect(created_user_formatted[:data][:attributes][:token]).to be_a(String)

      expect(created_user_formatted[:data][:attributes]).to have_key(:role)
      expect(created_user_formatted[:data][:attributes][:role]).to be_a(String)

      expect(created_user_formatted[:data][:attributes]).to have_key(:spotify_id)
      expect(created_user_formatted[:data][:attributes][:spotify_id]).to be_a(String)
    end

    it "if passed attributes are missing or boolean is nil, error 400 is sent with message" do
      user_params = ({
            "username": "Buzzy Bees",
            "email": "something@something.com",
            "token": nil
        }
      )
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)

      expect(response.status).to eq(400)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Validation failed: Token can't be blank, Role can't be blank, Spotify can't be blank"
                }
            ]
        }
          )
    end
  end
end