require 'rails_helper'

RSpec.describe PlaylistFacade do
  before do
    @user = User.create(username: 'Ollie', email: 'ol@lie.com', token: ENV['REFRESH_TOKEN'], spotify_id: '1281426323') 
    @facade = PlaylistFacade.new(@user)
    @service = SpotifyService.new(@user.token)

  end
  
  describe '#create_playlist' do
    it 'creates a new playlist' do
      params = { name: 'Facade Test Playlist', range: 5, input_address: 'north pole', host_id: @user.id }
      playlist = @facade.create_playlist(params)
      
      expect(playlist).to be_a(Playlist)
      expect(playlist.name).to eq('Facade Test Playlist')
      
      spotify_playlist = @service.fetch_playlist(playlist.spotify_id)
      expect(spotify_playlist[:name]).to eq('Facade Test Playlist')
    end
  end
  
  describe '#populate_playlist' do
    it 'populates a playlist with tracks' do
      params = { name: 'Facade Test Populated Playlist', range: 5, input_address: 'north pole', host_id: @user.id }

      playlist = @facade.create_playlist(params)
      
      playlist.suggestions.create(seed_type: 'genre', request: 'pop')
      playlist.suggestions.create(seed_type: 'genre', request: 'rock')
      playlist.suggestions.create(seed_type: 'track', spotify_track_id: '0Svkvt5I79wficMFgaqEQJ')
      playlist.suggestions.create(seed_type: 'track', spotify_track_id: '7lQ8MOhq6IN2w8EYcFNSUk')
      playlist.suggestions.create(seed_type: 'artist', spotify_artist_id: '2h93pZq0e7k5yf4dywlkpM')
      playlist.suggestions.create(seed_type: 'genre', request: 'techno')

      populated_playlist = @facade.populate_playlist(playlist)
  
      expect(populated_playlist).to be_a(Playlist)
  
      spotify_playlist = @service.fetch_playlist(populated_playlist.spotify_id)
      expect(spotify_playlist[:tracks][:items].length).to be 20
    end
  end
end
