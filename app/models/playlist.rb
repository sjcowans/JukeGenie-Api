class Playlist < ApplicationRecord
  has_many :playlist_tracks
  has_many :user_playlists
  has_many :users, through: :user_playlists
  has_many :suggestions

  validates :spotify_id, presence: true
end
