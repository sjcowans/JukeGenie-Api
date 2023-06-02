class SpotifyService
  def initialize(access_token)
    @access_token = access_token
  end

  def get(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.spotify.com/v1/') do |conn|
      conn.headers['Authorization'] = "Bearer #{@access_token}"
    end
  end

  def recommendations(seeds)
    response = conn.get do |req|
      req.url "recommendations"
      req.params["seed_artists"] = seeds[:artists].join(",") if seeds[:artists]
      req.params["seed_genres"] = seeds[:genres].join(",") if seeds[:genres]
      req.params["seed_tracks"] = seeds[:tracks].join(",") if seeds[:tracks]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def search(query, type, market, limit, offset)
    response = conn.get do |req|
      req.url 'search', {
        query: query,
        type: type,
        market: market,
        limit: limit,
        offset: offset
      }
    end
    JSON.parse(response.body, symbolize_names: true)
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