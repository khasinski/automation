RSpec.describe 'GET /charts', type: :request do
  let(:user) { create(:user) }

  context 'when params are correct' do
    before { get chart_path(1), headers: {'Authorization' => "Bearer #{user.authentication_token}" }}

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end
  end
end
