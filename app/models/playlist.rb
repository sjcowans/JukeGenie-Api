class Playlist < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :playlist_tracks
  has_many :user_playlists
  has_many :users, through: :user_playlists
  has_many :suggestions

  validates :spotify_id, presence: true
end
