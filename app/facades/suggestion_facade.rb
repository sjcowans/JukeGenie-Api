class SuggestionFacade
  def initialize(user)
    @user = user
    @service = SpotifyService.new(user.token)
  end

  def create_suggestion(params)
    suggestion = Suggestion.create(
      user_id: @user.id,
      playlist_id: params[:playlist_id],
      seed_type: params[:seed_type],
      request: params[:request],
      track_artist: params[:track_artist]
    )

    if params[:seed_type] == 'artist'
      suggestion.spotify_artist_id = spotify_artist(params[:request])
    elsif params[:track_artist].present?
      suggestion.spotify_artist_id = spotify_artist(params[:track_artist])
    elsif params[:seed_type] == 'track'
      suggestion.spotify_track_id = spotify_track(params[:request])
    end

    suggestion.save
    suggestion
  end

  private

  def spotify_artist(name)
    artist = Artist.find_by(name: name.capitalize)
    if artist
      artist.spotify_id
    else
      info = @service.search({
        type: 'artist',
        artist: name
      })[:artists][:items].first
      new_artist = Artist.create(
        name: info[:name],
        spotify_id: info[:id]
        genres: info[:genres]
        popularity: info[:popularity]
        images: info[:images]
      )
      new_artist.spotify_id
    end
  end

  def spotify_track(name)
    track = Track.find_by(name: name.capitalize)
    if track
      track.spotify_id
    else
      info = @service.search({
        type: 'track',
        track: name
      })[:tracks][:items].first
      new_track = Track.create(
        name: info[:name],
        spotify_id: info[:id]
        popularity: info[:popularity]
        images: info[:images]
      )
      new_track.spotify_id
    end
  end
end
