class SpotifyService
  def self.get(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.spotify.com/v1') do |request|
      request.headers['Authorization'] = "Bearer #{ENV['SPOTIFY_TOKEN']}"
    end
  end

  def self.genre_search
    get_url('')
  end

  def self.artist_search
    get_url('')
  end

  def self.song_search
    get_url('')
  end

  def self.get_playlist
    get_url('')
  end
end