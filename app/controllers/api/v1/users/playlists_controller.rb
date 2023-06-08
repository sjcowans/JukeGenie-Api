class Api::V1::Users::PlaylistsController < ApplicationController
  def index
    @user = User.find(params[:id])
    render json: { hosted_playlists: Playlist.where("host_id = #{@user.id}"), joined_playlists: Playlist.joins(:user_playlists).where(user_playlists: {dj: false, user_id: "#{@user.id}"}) }
  end

  def create
    @user = User.find(params[:user_id])
    @facade = PlaylistFacade.new(@user)
    playlist = @facade.create_user_playlist(playlist_params)
    render json: PlaylistSerializer.new(playlist).serializable_hash.to_json, status: :created
  end

  private

  def playlist_params
    params.permit(:join_code, :user_id)
  end
end


