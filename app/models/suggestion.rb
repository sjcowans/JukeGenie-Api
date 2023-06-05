class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :type, presence: true
  validates :request, presence: true

  enum type: %w(track artist genre)
end
