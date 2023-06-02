require 'rails_helper'

RSpec.describe UserPlaylist, type: :model do
  describe 'relationships' do
    it { should belong_to :suggestions}
    it { should belong_to :user_playlists}
  end
end