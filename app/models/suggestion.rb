class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :media_type, presence: true
  validates :request, presence: true
  validates :user_id, presence: true
  validates :playlist_id, presence: true

  enum media_type: %w(track artist genre)
end
