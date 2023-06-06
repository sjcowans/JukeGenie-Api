require 'rails_helper'

describe 'Tracks API' do
  describe 'GET /api/v1/tracks/:id' do
    it 'sends a Track within a key of data' do
      track = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")

      get "/api/v1/tracks/#{track.id}"
      
      parsed_track = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      expect(parsed_track[:data]).to have_key(:id)
      expect(parsed_track[:data][:id]).to be_a(String)

      expect(parsed_track[:data]).to have_key(:type)
      expect(parsed_track[:data][:type]).to be_a(String)
      expect(parsed_track[:data][:type]).to eq("track")

      expect(parsed_track[:data]).to have_key(:attributes)
      expect(parsed_track[:data][:attributes]).to be_a(Hash)

      expect(parsed_track[:data][:attributes]).to have_key(:name)
      expect(parsed_track[:data][:attributes][:name]).to be_a(String)

      expect(parsed_track[:data][:attributes]).to have_key(:spotify_track_id)
      expect(parsed_track[:data][:attributes][:spotify_track_id]).to be_a(String)
    end

    it "if input ID is not in database, error is sent" do
      track = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")

      get "/api/v1/tracks/123456"
      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Couldn't find Track with 'id'=123456"
                }
            ]
        }
          )
    end
  end

  describe "POST /api/v1/tracks" do
    it "is passed attributes required as JSON and creates a new track" do
      track_params = ({
        "name": "Chicken Fried",
        "spotify_track_id": "chickenfried"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/tracks", headers: headers, params: JSON.generate(track: track_params)

      created_track = Track.last
      created_track_formatted = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
  
      expect(created_track_formatted[:data]).to have_key(:id)
      expect(created_track_formatted[:data][:id]).to be_a(String)

      expect(created_track_formatted[:data]).to have_key(:type)
      expect(created_track_formatted[:data][:type]).to be_a(String)
      expect(created_track_formatted[:data][:type]).to eq("track")

      expect(created_track_formatted[:data]).to have_key(:attributes)
      expect(created_track_formatted[:data][:attributes]).to be_a(Hash)

      expect(created_track_formatted[:data][:attributes]).to have_key(:name)
      expect(created_track_formatted[:data][:attributes][:name]).to be_a(String)

      expect(created_track_formatted[:data][:attributes]).to have_key(:spotify_track_id)
      expect(created_track_formatted[:data][:attributes][:spotify_track_id]).to be_a(String)
    end

    it "if passed attributes are missing or boolean is nil, error 400 is sent with message" do
      track_params = ({
        "name": nil,
        "spotify_track_id": "chickenfried"
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/tracks", headers: headers, params: JSON.generate(track: track_params)

      expect(response.status).to eq(400)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Validation failed: Name can't be blank"
                }
            ]
        }
          )
    end
  end

  describe "POST /api/v1/tracks/:id" do
    it "can patch attributes passed as JSON to a user" do
      track = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")
      og_track = Track.last

      track_params = {
        "name": "Colder Wheather",
        "spotify_track_id": "ColderWheather"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/tracks/#{track.id}", headers: headers, params: JSON.generate({track: track_params})
      updated_track = Track.find_by(id: track.id)

      expect(response).to be_successful
      expect(updated_track.name).to_not eq(og_track.name)
      expect(updated_track.spotify_track_id).to_not eq(og_track.spotify_track_id)
      expect(updated_track.name).to eq("Colder Wheather")
      expect(updated_track.spotify_track_id).to eq("ColderWheather")
    end

    it 'if ID does not match any in the database an error is sent' do
      track_params = {
        "name": "Colder Wheather",
        "spotify_track_id": "ColderWheather"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/tracks/12345", headers: headers, params: JSON.generate({track: track_params})
      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Couldn't find Track with 'id'=12345"
                }
            ]
        }
          )
    end

    it 'if there are missing attributes then an error is sent back' do
      track = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")
      og_track = Track.last

      track_params = {
        "name": "Colder Wheather",
        "spotify_track_id": nil
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/tracks/#{track.id}", headers: headers, params: JSON.generate({track: track_params})
      expect(response.status).to eq(400)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Validation failed: Spotify track can't be blank"
                }
            ]
        }
          )
    end
  end

  describe 'delete /api/v1/tracks/{track_id}' do
    it 'can delete a track' do
      track1 = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")
      track2 = Track.create!(spotify_track_id: "ColderWheather", name: "Colder Wheather")
 
      delete "/api/v1/tracks/#{track1.id}"

      expect(Track.all).to eq([track2])
    end

    it 'sends back an error if the ID does not match any in the database' do
      track1 = Track.create!(spotify_track_id: "chickenfired", name: "Chicken Fried")
      track2 = Track.create!(spotify_track_id: "ColderWheather", name: "Colder Wheather")
 
      delete "/api/v1/tracks/12345"
      expect(response.status).to eq(404)
      expect(response).to_not be_successful

      error_message = JSON.parse(response.body, symbolize_names: true)
      expect(error_message).to eq({
            "errors": [
                {
                    "detail": "Couldn't find Track with 'id'=12345"
                }
            ]
        }
          )
    end
  end
end