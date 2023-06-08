require 'rails_helper'

describe "Suggestions API Calls" do
  describe "POST /api/v1/suggestions" do
    it "is passed valid ids as JSON from user and playlist and creates a suggestion" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", spotify_id: "fasidfuasfd")
      playlist = Playlist.create!(name: "Bob's playlist", latitude: 1.120394, longitude: 1.352345, host_id: user.id, spotify_id: "q3oriu", input_address: "This address")

      user_playlist = UserPlaylist.create!(user_id: user.id, playlist_id: playlist.id)

      expect(user.suggestions.count).to eq(0)
      expect(playlist.suggestions.count).to eq(0)

      suggestions_params = {
          "user_id": user.id,
          "playlist_id": playlist.id,
          "seed_type": 0,
          "request": "Hey Jude"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestions_params)
      
      expect(response).to be_successful
      expect(response.status).to eq(201)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce[:data]).to have_key(:id)
      expect(formatted_responce[:data][:id]).to be_a(String)

      expect(formatted_responce[:data]).to have_key(:type)
      expect(formatted_responce[:data][:type]).to be_a(String)
      expect(formatted_responce[:data][:type]).to eq("suggestion")

      expect(formatted_responce[:data]).to have_key(:attributes)
      expect(formatted_responce[:data][:attributes]).to be_a(Hash)

      expect(formatted_responce[:data][:attributes]).to have_key(:seed_type)
      expect(formatted_responce[:data][:attributes][:seed_type]).to be_a(String)

      expect(formatted_responce[:data][:attributes]).to have_key(:playlist_id)
      expect(formatted_responce[:data][:attributes][:playlist_id]).to be_a(Integer)

      expect(formatted_responce[:data][:attributes]).to have_key(:request)
      expect(formatted_responce[:data][:attributes][:request]).to be_a(String)

      expect(formatted_responce[:data][:attributes]).to have_key(:user_id)
      expect(formatted_responce[:data][:attributes][:user_id]).to be_a(Integer)

      expect(formatted_responce[:data][:attributes]).to have_key(:spotify_artist_id)
      expect(formatted_responce[:data][:attributes][:spotify_artist_id]).to eq(nil)

      expect(formatted_responce[:data][:attributes]).to have_key(:track_artist)
      expect(formatted_responce[:data][:attributes][:track_artist]).to eq(nil)

      suggestion = Suggestion.last

      expect(user.suggestions).to include(suggestion)
      expect(playlist.suggestions).to include(suggestion)
    end

    it "if input id(s) are not valid, error 404 with message is sent" do
      suggestions_params = {
        "user_id": "29382",
        "playlist_id": "23094",
        "seed_type": 0,
        "request": "Hey Jude"
    }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestions_params)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to eq({
        "errors": [
              {
                  "detail": "Couldn't find User with 'id'=29382"
              }
          ]
      }
        )
    end

    it "if user or playlist id are not passed in, error 400 with message is sent" do
      suggestions_params = {
        "user_id": "",
        "playlist_id": "",
        "seed_type": 0,
        "request": "Hey Jude"
    }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestions_params)

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Couldn't find User with 'id'="
                }
            ]
        }
          )
    end

    it "if suggestion already exists based on ids, new suggestion is still created" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", spotify_id: "fasidfuasfd")
      playlist = Playlist.create!(name: "Bob's playlist", latitude: 1.120394, longitude: 1.352345, host_id: user.id, spotify_id: "q3oriu", input_address: "This address")

      user_playlist = UserPlaylist.create!(user_id: user.id, playlist_id: playlist.id, dj: true)

      suggestion1 = Suggestion.create!(user_id: user.id, playlist_id: playlist.id, seed_type: 0, request: "Hey Jude")

      suggestions_params = {
          "user_id": user.id,
          "playlist_id": playlist.id,
          "seed_type": 0,
          "request": "Golden Slumbers"
      }


      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestions_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce[:data]).to have_key(:id)
      expect(formatted_responce[:data][:id]).to be_a(String)

      expect(formatted_responce[:data]).to have_key(:type)
      expect(formatted_responce[:data][:type]).to be_a(String)
      expect(formatted_responce[:data][:type]).to eq("suggestion")

      expect(formatted_responce[:data]).to have_key(:attributes)
      expect(formatted_responce[:data][:attributes]).to be_a(Hash)

      expect(formatted_responce[:data][:attributes]).to have_key(:seed_type)
      expect(formatted_responce[:data][:attributes][:seed_type]).to be_a(String)

      expect(formatted_responce[:data][:attributes]).to have_key(:playlist_id)
      expect(formatted_responce[:data][:attributes][:playlist_id]).to be_a(Integer)

      expect(formatted_responce[:data][:attributes]).to have_key(:request)
      expect(formatted_responce[:data][:attributes][:request]).to be_a(String)

      expect(formatted_responce[:data][:attributes]).to have_key(:user_id)
      expect(formatted_responce[:data][:attributes][:user_id]).to be_a(Integer)

      expect(formatted_responce[:data][:attributes]).to have_key(:spotify_artist_id)
      expect(formatted_responce[:data][:attributes][:spotify_artist_id]).to eq(nil)

      expect(formatted_responce[:data][:attributes]).to have_key(:track_artist)
      expect(formatted_responce[:data][:attributes][:track_artist]).to eq(nil)


      suggestion2 = Suggestion.last

      expect(user.suggestions).to include(suggestion2)
      expect(playlist.suggestions).to include(suggestion2)

      expect(user.suggestions.count).to eq(2)
      expect(playlist.suggestions.count).to eq(2)
    end
  end

  describe "DELETE /api/v1/suggestions" do
    it "destroys the existing suggestion" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", spotify_id: "fasidfuasfd")
      playlist = Playlist.create!(name: "Bob's playlist", latitude: 1.120394, longitude: 1.352345, host_id: user.id, spotify_id: "q3oriu", input_address: "This address")

      user_playlist = UserPlaylist.create!(user_id: user.id, playlist_id: playlist.id, dj: true)

      suggestion1 = Suggestion.create!(user_id: user.id, playlist_id: playlist.id, seed_type: 0, request: "Hey Jude")

      expect(Suggestion.count).to eq(1)
      expect(user.suggestions.count).to eq(1)

      suggestion_params = {
          "user_id": user.id,
          "playlist_id": playlist.id,
          "request": suggestion1.request
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestion_params)


      expect(response).to be_successful
      expect(response.status).to eq(204)

      expect(Suggestion.count).to eq(0)
      expect(user.suggestions.count).to eq(0)

      expect{Suggestion.find(suggestion1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "if passed in ids do not lead to a found Suggestion, error 404 is sent" do
      user = User.create!(username: "Bob", email: "bob@bob.com", token: "fasodijasdfokn", spotify_id: "fasidfuasfd")
      playlist = Playlist.create!(name: "Bob's playlist", latitude: 1.120394, longitude: 1.352345, host_id: user.id, spotify_id: "q3oriu", input_address: "This address")

      user_playlist = UserPlaylist.create!(user_id: user.id, playlist_id: playlist.id, dj: true)

      suggestion1 = Suggestion.create!(user_id: user.id, playlist_id: playlist.id, seed_type: 0, request: "Hey Jude")



      suggestion_params = {
          "user_id": user.id,
          "playlist_id": "11111111"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v1/suggestions", headers: headers, params: JSON.generate(suggestion: suggestion_params)

      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to eq({
              "errors": [
                  {
                      "detail": "No Suggestion with user_id=#{user.id} AND playlist_id=11111111 exists OR request is not found for this playlist and user combination"
                  }
              ]
          }
        )
    end
  end
end