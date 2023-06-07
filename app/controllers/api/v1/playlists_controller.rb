class Api::V1::PlaylistsController < ApplicationController
  before_action :initialize_facade, only: [:create, :populate]
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create
    playlist = @facade.create_playlist(playlist_params)
    render json: PlaylistSerializer.new(playlist).serializable_hash.to_json, status: :created
  end
  
  def index
    playlists = []
    Playlist.find_each do |playlist|
      playlists.push(playlist) if playlist.range > playlist.distance_to([params["lat"], params["lng"]])
    end
    if playlists.empty?
      render json: ErrorSerializer.new(playlists).no_playlists_found, status: 404
    else
      render json: PlaylistSerializer.new(playlists).serializable_hash.to_json, status: 200
    end
  end

  def populate
    playlist = Playlist.find_by(spotify_id: params[:spotify_id])
    @facade.populate_playlist(playlist)
    render json: PlaylistSerializer.new(playlist).serializable_hash.to_json, status: :ok
  end

  private

  def initialize_facade
    user = User.find_by(params[:host_id])
    @facade = PlaylistFacade.new(user)
  end

  def playlist_params
    params.require(:playlist).permit(:name, :longitude, :latitude, :input_address, :range, :spotify_id, :host_id)
  end

  def record_invalid(exception)
    render json: ErrorSerializer.new(exception.record.errors).user_invalid_attributes_serialized_json, status: :unprocessable_entity
  end  
end
