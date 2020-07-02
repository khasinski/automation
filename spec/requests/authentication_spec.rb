# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users/sign_in', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/users/sign_in' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      auth_header = response.headers['Authorization'] and token = auth_header.split(' ').last
      decoded_token = JsonWebToken.decode(token)
      expect(decoded_token.first['user_email']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end
