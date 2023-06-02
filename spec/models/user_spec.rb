require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :suggestions }
    it { should have_many :user_playlists }
    it { should have_many(:playlists).through(:user_playlists) }
  end
end