require 'rails_helper'

RSpec.describe PlaylistTrack, type: :model do
  describe 'relationships' do
    it { should belong_to :playlist_tracks }
    it { should belong_to :user_playlists }
  end
end