# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviceSessionsController, type: :controller do
  context 'when device is created' do
    let(:user) { create(:user) }
    let(:device) { create(:device, user: user) }

    it 'returns http UNAUTHORISED on GET #new_session without credentials' do
      get :new_session
      expect(response).to have_http_status(401)
    end

    it 'returns http success on GET #new_session with credentials and provides a token, sets ip columns' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return('192.168.0.1')
      get :new_session, params: { device: { name: device.name, password: 'password' } }

      expect(assigns(:current_ip)).to eq('192.168.0.1')
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to have_key('authentication_token')
    end
  end
end
