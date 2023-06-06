class SuggestionFacade
  def initialize(user)
    @user = user
    @service = SpotifyService.new(user.token)
  end

  def create_suggestion(params)
    suggestion = Suggestion.create(
      user_id: @user.id,
      playlist_id: params[:playlist_id],
      type: params[:type],
      request: params[:request],
      track_artist: params[:track_artist]
    )

    if params[:type] == 'artist'
      suggestion.spotify_artist_id = spotify_artist(params[:request])
    elsif params[:track_artist].present?
      suggestion.spotify_artist_id = spotify_artist(params[:track_artist])
    end

    suggestion.save
    suggestion
  end

  private

  def spotify_artist(name)
    artist = Artist.find_by(name: name)
    if artist
      artist.spotify_id
    else
      new_artist = Artist.create(
        name: name,
        spotify_id: @service.search({
          type: 'artist',
          artist: name
        })[:artists][:items].first[:id]
      )
      new_artist.spotify_id
    end
  end
end
