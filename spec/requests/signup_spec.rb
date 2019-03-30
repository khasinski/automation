require 'rails_helper'

RSpec.describe 'POST /users', type: :request do
  let(:url) { '/users' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end
  let(:invalid_params) do
    {
      user: {
        email: 'user@gmail.com',
        password: 'password'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 201' do
      expect(response.status).to eq 201
    end

    it 'returns a new user' do
      body = JSON.parse(response.body)
      expect(body).to have_key("created_at")
    end
  end

  context 'when user already exists' do
    before do
      create(:user)
      post url, params: invalid_params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 422
    end

    it 'returns validation errors' do
      body = JSON.parse(response.body)
      expect(body['email'].first).to eq("has already been taken")
    end
  end
end
