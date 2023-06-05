require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :playlist }

    it { should validate_presence_of :media_type }
    it { should validate_presence_of :request }
  end
end