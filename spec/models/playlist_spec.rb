require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'relationships' do
    it { should have_many :playlist_tracks}
    it { should have_many :user_playlists}
    it { should have_many(:users).through(:user_playlists)}
    it { should have_many :suggestions }

  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:input_address) }
    it { should validate_presence_of(:range) }
  end
end