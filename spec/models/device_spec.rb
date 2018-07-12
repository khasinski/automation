require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'validations' do
    it 'fails validation with no type' do
      device = Device.new
      expect(device).to_not be_valid
      expect(device.errors[:type]).to eq ["is not included in the list"]
    end

    it 'fails validation with illegal type' do
      device = Device.new
      device.type = "notmytype"
      expect(device).to_not be_valid
      expect(device.errors[:type]).to eq ["is not included in the list"]
    end

    it 'passes validation with "AquariumController" type' do
      device = Device.new
      device.type = "AquariumController"
      expect(device).to be_valid
    end

    it 'passes validation with "Light" type' do
      device = Device.new
      device.type = "Light"
      expect(device).to be_valid
    end
  end

end
