require 'rails_helper'

RSpec.describe DevicesController, type: :controller do

  context "when device is created" do
    let(:device) { create(:device) }

    it "finds device by name and id" do
      get :show, params: {:id => device.name }
    end

    it "not update Device measurements on REPORT without an access token" do
      post :report, params: {:id => device.name, :device => {:authentication_token => nil} }
      expect(response).to have_http_status(401)
    end

    it "updates Device measurements on REPORT with an access token" do
      post :report, params: {:id => device.name, :device => {:authentication_token => device.authentication_token, :reports => {:temperature => 10.5, :volume => 20}} }
      expect(response).to have_http_status(200)
      resp = JSON.parse(response.body)
      expect(resp).to have_key("authentication_token")
    end

  end


end
