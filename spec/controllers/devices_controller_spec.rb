require 'rails_helper'

RSpec.describe DevicesController, type: :controller do

  context "when device is created" do
    let(:device) { create(:device) }

    it "finds device by name and id" do
      get :show, params: {name: device.name }
    end

    it "gets light device settings" do
      get :device_settings, params: {name: device.name }
      settings = JSON.parse(response.body)["settings"]
      assert_equal 3.hours.ago.to_i, settings["turn_on_time"]
      assert_equal 4.hours.from_now.to_i, settings["turn_off_time"]
      assert_equal 50, settings["intensity"]
      assert_equal true, settings["on"]
    end
  end


end
