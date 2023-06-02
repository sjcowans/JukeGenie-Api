class SpotifyService
  def initialize(access_token)
    @access_token = access_token
  end

  def recommendations(seeds)
    response = conn.get do |req|
      req.url 'recommendations', {
      seed_artists: seeds[:artists].join(',') if seeds[:artists],
      seed_genres: seeds[:genres].join(',') if seeds[:genres],
      seed_tracks: seeds[:tracks].join(',') if seeds[:tracks],
      market: "US"
      }
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def search(params, type)
    response = conn.get do |req|
      req.url 'search', { 
        query: querify(params), 
        type: type,
        limit: 1,
        market: "US"
      }
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def create_playlist(user_id, playlist_name)
    response = conn.post do |req|
      req.url "/users/#{user_id}/playlists", {
        name: playlist_name,
        public: true,
        collaborative: true
      }
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def add_tracks_to_playlist(playlist_id, track_uris, position: nil)
    response = conn.post do |req|
      req.url "/playlists/#{playlist_id}/tracks", {
        uris: track_uris,
        position: position
      }
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_playlist(playlist_id)
    response = conn.get do |req|
      req.url "/playlists/#{playlist_id}"
      req.params['fields'] = tracks.items(track(name,href,album(name,href)))
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def conn
    Faraday.new(url: 'https://api.spotify.com/v1/') do |conn|
      conn.headers['Authorization'] = "Bearer #{@access_token}"
    end
  end

  def querify(params)
    query_parts = []
  
    query_parts << "artist:#{params[:artist]}" if params[:artist] && !params[:artist].empty?
    query_parts << "track:#{params[:track]}" if params[:track] && !params[:track].empty?
    query_parts << "genre:#{params[:genre]}" if params[:genre] && !params[:genre].empty?
  
    query_parts.join("%20")
  end
end