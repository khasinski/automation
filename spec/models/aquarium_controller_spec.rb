require 'rails_helper'

RSpec.describe AquariumController, type: :model do
  describe 'validations' do
    it { should have_one :valve_controller }
  end

  context "with valve_controller associated" do
    it "turns on valve when distance too big and turns it off when distance back low" do
      aquarium_controller = Device.new(type: "AquariumController", name: "test_aquarium", distance: 100)
      aquarium_controller.save
      valve = aquarium_controller.create_valve_controller(name: "test_valve")
      expect(valve.on?).to be_falsey
      aquarium_controller.react_to_reported_data([{"distance" => 101}])
      expect(valve.on?).to be_truthy
      aquarium_controller.react_to_reported_data([{"distance" => 100}])
      expect(valve.on?).to be_falsey
    end
  end
end
