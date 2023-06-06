class PlaylistFacade
  def initialize(user)
    @user = user
    @service = SpotifyService.new(user.token)
  end

  def create_playlist(params)
    playlist_data = @service.create_playlist(@user.spotify_id, params[:name])
    playlist = Playlist.create(
      name: params[:name],
      spotify_id: playlist_data[:id],
      lon: params[:lon],
      lat: params[:lat]
    )
    UserPlaylist.create(user_id: @user.id, playlist_id: playlist.id, host: true)

    playlist_data
  end
end
