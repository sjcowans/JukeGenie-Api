require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'relationships' do
    it { should has_many :playlist_tracks }
  end
end