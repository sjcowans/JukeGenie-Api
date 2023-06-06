class Track < ApplicationRecord
  has_many :playlist_tracks

  validates :name, presence: true
  validates :spotify_track_id, presence: true
end
