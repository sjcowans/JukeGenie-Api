require 'rails_helper'

RSpec.describe PlaylistTrack, type: :model do
  describe 'relationships' do
    it { should belong_to :track }
    it { should belong_to :playlist }
  end
end