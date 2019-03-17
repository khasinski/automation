require 'rails_helper'

RSpec.describe ValveController, type: :model do
  describe 'validations' do
    it { should belong_to :aquarium_controller }
  end
end
