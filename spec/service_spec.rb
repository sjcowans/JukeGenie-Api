require 'rails_helper'

RSpec.describe SpotifyService do
  before do
    refresh_token = ENV['REFRESH_TOKEN']
    @service = SpotifyService.new(refresh_token)
  end

  it 'can make recommendations' do
    seeds = {
      artists: ['2h93pZq0e7k5yf4dywlkpM'],
      genres: ['pop', 'rock'],
      tracks: ['0Svkvt5I79wficMFgaqEQJ', '7lQ8MOhq6IN2w8EYcFNSUk']
    }

    result = @service.recommendations(seeds)

    expect(result).to be_a(Hash)
    expect(result[:tracks]).to be_an(Array)
  end

  it 'can search for a track' do
    params = {
      artist: "Linkin Park",
      track: "In The End"
      type: "track"
    }

    result = @service.search(params)

    expect(result).to be_a(Hash)
    expect(result[:tracks]).to be_a(Hash)
    expect(result[:tracks][:items].first[:name]).to eq("In the End")
    expect(result[:tracks][:items].first[:artists].first[:name]).to eq("Linkin Park")
  end

  it 'can create a playlist' do
    user_id = "1281426323"
    playlist_name = "My Test Playlist"

    result = @service.create_playlist(user_id, playlist_name)

    expect(result).to be_a(Hash)
    expect(result[:name]).to eq(playlist_name)
  end

  it 'can add tracks to a playlist' do
    playlist_id = '53wxBdREY48iHXn8Ke7PAJ'
    track_uris = ['spotify:track:2TpxZ7JUBn3uw46aR7qd6V', 'spotify:track:7dt6x5M1jzdTEt8oCbisTK']

    result = @service.add_tracks_to_playlist(playlist_id, track_uris)

    expect(result).to be_a(Hash)
    expect(result[:snapshot_id]).to be_present

    playlist = @service.get_playlist(playlist_id)

    expect(playlist).to be_a(Hash)
    expect(playlist[:tracks]).to be_a(Hash)
  end
end
