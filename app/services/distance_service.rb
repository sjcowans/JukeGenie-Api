class DistanceService

  def self.get(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/distancematrix') do |request|
      request...
    end
  end
end