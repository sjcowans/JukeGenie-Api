require 'rails_helper'

describe "Playlists API" do
  describe "GET /api/v1/playlists" do
    it "sends all playlists within a key of data" do
      Playlist.create!(name: "Jump Up", range: 1000, input_address: "8500 Peña Blvd. Denver, CO 80249-6340")
      Playlist.create!(name: "Jump Down from there", range: 900, input_address: "1560 Broadway Denver, CO 80202")

      @user = User.create!(username: "Henry", email: "henry@henry.com", token: "230984230948", spotify_id: "2304928430")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      params = ({"lat"=>39.7866467, "lng"=>-104.8876735})

      headers = {"CONTENT_TYPE" => "application/json"}

      
      get '/api/v1/playlists',headers: headers, params: params
      
      expect(response).to be_successful
  
      playlists = JSON.parse(response.body, symbolize_names: true)
  
      expect(playlists[:data].count).to eq(2)
  
      playlists[:data].each do |playlist|
        expect(playlist).to have_key(:id)
        expect(playlist[:id]).to be_a(String)

        expect(playlist).to have_key(:type)
        expect(playlist[:type]).to be_a(String)
        expect(playlist[:type]).to eq("playlist")

        expect(playlist).to have_key(:attributes)
        expect(playlist[:attributes]).to be_a(Hash)
  
        expect(playlist[:attributes]).to have_key(:name)
        expect(playlist[:attributes][:name]).to be_a(String)
  
        expect(playlist[:attributes]).to have_key(:street)
        expect(playlist[:attributes][:range]).to be_a(Float)
  
        expect(playlist[:attributes]).to have_key(:latitude)
        expect(playlist[:attributes][:latitude]).to be_a(Float)
  
        expect(playlist[:attributes]).to have_key(:longitude)
        expect(playlist[:attributes][:longitude]).to be_a(Float)
  
        expect(playlist[:attributes]).to have_key(:state)
        expect(playlist[:attributes][:input_address]).to be_a(String)
  
        expect(playlist[:attributes]).to have_key(:spotify_id)
        expect(playlist[:attributes][:spotify_id]).to eq(nil)
      end
    end
  end
end