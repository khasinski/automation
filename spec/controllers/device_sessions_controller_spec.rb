require 'rails_helper'

RSpec.describe DeviceSessionsController, type: :controller do
  context "when device is created" do
    let(:device) { create(:device) }

    it "returns http UNAUTHORISED on GET #new_session without credentials" do
      get :new_session
      expect(response).to have_http_status(401)
    end

    it "returns http success on GET #new_session with credentials and provides a token" do
      get :new_session, params: {:device => {:name => device.name, :password => device.password} }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to have_key("access_token")
    end
  end


end
