class SpotifyService
  def initialize(refresh_token)
    @access_token = get_access_token(refresh_token)
  end

  def recommendations(seeds)
    response = conn.get do |req|
      req.url 'recommendations'
      req.params[:seed_artists] = seeds[:artists].join(',') if seeds[:artists]
      req.params[:seed_genres] = seeds[:genres].join(',') if seeds[:genres]
      req.params[:seed_tracks] = seeds[:tracks].join(',') if seeds[:tracks]
      req.params[:market] = "US"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def search(params)
    response = conn.get do |req|
      req.url 'search'
      req.params = { 
        q: querify(params), 
        type: params[:type],
        limit: 1,
        market: "US"
      }
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def create_playlist(user_id, playlist_name)
    response = conn.post do |req|
      req.url "users/#{user_id}/playlists"
      req.headers['Content-Type'] = 'application/json'
      req.body = { name: playlist_name }.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def add_tracks_to_playlist(playlist_id, track_uris, position: nil)
    response = conn.post do |req|
      req.url "playlists/#{playlist_id}/tracks"
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        uris: track_uris,
        position: position
      }.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_playlist(playlist_id)
    response = conn.get do |req|
      req.url "playlists/#{playlist_id}"
      req.headers['Content-Type'] = 'application/json'
      req.params['fields'] = 'tracks.items(track(name,href,album(name,href)))'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def conn
    Faraday.new(url: 'https://api.spotify.com/v1/') do |conn|
      conn.headers['Authorization'] = "Bearer #{@access_token}"
    end
  end

  def get_access_token(refresh_token)
    credentials = Base64.strict_encode64("#{ENV['CLIENT_ID']}:#{ENV['CLIENT_SECRET']}")
    response = Faraday.new(url: 'https://accounts.spotify.com/api/token').post do |req|
      req.headers['Authorization'] = "Basic #{credentials}"
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = URI.encode_www_form({
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      })
    end
    JSON.parse(response.body)["access_token"]
  end

  def querify(params)
    query_parts = []
  
    query_parts << "artist:#{params[:artist]}" if params[:artist].present?
    query_parts << "track:#{params[:track]}" if params[:track].present?
    query_parts << "genre:#{params[:genre]}" if params[:genre].present?
  
    query_parts.join(" ")
  end  
end