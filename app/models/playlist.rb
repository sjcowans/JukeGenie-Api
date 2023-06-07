class Playlist < ApplicationRecord
  has_many :playlist_tracks
  has_many :user_playlists
  has_many :users, through: :user_playlists
  has_many :suggestions

  validates :spotify_id, presence: true

  validates_presence_of :input_address
  validates_presence_of :range
  validates_presence_of :name

  geocoded_by :address
  after_validation :geocode

  def address
    input_address
  end
end
