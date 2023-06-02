class User < ApplicationRecord
  has_many :suggestions
  has_many :user_playlists
  has_many :playlists, through: :user_playlists
  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
