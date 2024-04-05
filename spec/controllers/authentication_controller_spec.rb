require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    context 'with valid credentials' do
      let(:valid_user) { create(:user, username: ENV['username'], email: ENV['email'],password: ENV['password']) }

      it 'returns a JWT token' do
        post :login, params: { username: valid_user.username, email: valid_user.email,password: valid_user.password }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post :login, params: { username: 'invalid_username', password: 'invalid_password' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).not_to have_key('token')
      end
    end
  end
end
