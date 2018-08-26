require 'rails_helper'

RSpec.describe DevicesController, type: :controller do

  context "when device is created" do
    let(:device) { create(:device) }

    #it "finds device by name and id" do
    #  get :show, params: {id: device.name }
    #  expect(response).to have_http_status(:ok)
    #end

    it "gets light device settings" do
      Timecop.freeze(Time.now) do
        get :device_settings, params: {id: device.name }
        settings = JSON.parse(response.body)["settings"]
        assert_equal 3.hours.ago.to_i, settings["turn_on_time"]
        assert_equal 4.hours.from_now.to_i, settings["turn_off_time"]
        assert_equal 50, settings["intensity"]
        assert_equal true, settings["on"]
      end
    end

    it 'updates settings and send it to device' do
      patch :update, params: {id: device.name , device: {turn_on_time: Time.now}}

      expect(response).to redirect_to device_path(device.id)
    end
  end


end
