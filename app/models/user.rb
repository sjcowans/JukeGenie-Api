class User < ApplicationRecord
  has_many :suggestions
  has_many :user_playlists
  has_many :playlists, through: :user_playlists

  validates :username, presence: true
  validates :email, presence: true
  validates :token, presence: true
  validates :role, presence: true
  validates :spotify_id, presence: true
end
