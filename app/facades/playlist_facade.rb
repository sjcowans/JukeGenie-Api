class PlaylistFacade
  def initialize(user)
    @user = user
    @service = SpotifyService.new(user.token)
  end

  def create_playlist(params)
    info = @service.create_playlist(@user.spotify_id, params[:name])
    playlist = Playlist.create(
      host_id: @user.id,
      name: info[:name],
      spotify_id: info[:id],
      range: params[:range],
      input_address: params[:input_address]
    )
    UserPlaylist.create(user_id: @user.id, playlist_id: playlist.id, dj: true)
    playlist
  end

  def populate_playlist(playlist)
    playlist.suggestions.each_slice(5).with_index do |batch, index|
      seeds = generate_seeds(batch)
      track_uris = create_tracks_and_get_uris(seeds, playlist)
      @service.add_tracks_to_playlist(playlist.spotify_id, track_uris, position: index*5)
    end
    playlist
  end

  private

  def generate_seeds(suggestions)
    seeds = {tracks: [], artists: [], genres: []}
    suggestions.each do |suggestion|
      case suggestion.seed_type
      when 'track'
        seeds[:tracks] << suggestion.spotify_track_id
      when 'artist'
        seeds[:artists] << suggestion.spotify_artist_id
      when 'genre'
        seeds[:genres] << suggestion.request
      end
    end
    seeds
  end

  def create_tracks_and_get_uris(seeds, playlist)
    track_uris = []
    recommendations = @service.get_recommendations(seeds)
    recommendations[:tracks].each do |track|
      our_track = Track.find_or_create_by(name: track[:name], spotify_id: track[:id])
      our_track.update(popularity: track[:popularity], images: track[:images])
      playlist_track = PlaylistTrack.create(playlist_id: playlist.id, track_id: our_track.id)
      track_uris << track[:uri]
    end
    track_uris
  end
end
