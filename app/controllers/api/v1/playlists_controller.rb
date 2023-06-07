class Api::V1::PlaylistsController < ApplicationController
  before_action :initialize_facade
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create
    playlist = @facade.create_playlist(playlist_params)
    render json: PlaylistSerializer.new(playlist).serializable_hash.to_json, status: :created
  end
  
  def index
    require 'pry'; binding.pry
    playlists = Playlist.where()
  end

  private

  def initialize_facade
    @facade = PlaylistFacade.new(current_user)
  end

  def playlist_params
    params.require(:playlist).permit(:name, :longitude, :latitude, :input_address, :range)
  end

  def record_invalid(exception)
    render json: ErrorSerializer.new(exception.record.errors).user_invalid_attributes_serialized_json, status: :unprocessable_entity
  end  
end
