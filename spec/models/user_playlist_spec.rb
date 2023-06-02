require 'rails_helper'

RSpec.describe UserPlaylist, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :playlist }
  end
end