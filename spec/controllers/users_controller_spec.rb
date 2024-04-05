# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { email: 'test@example.com', password: 'password', name: 'Test User', username: 'testuser' } }

      it 'creates a new user and generates JWT token' do
        post :create, params: { user: valid_attributes }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { email: nil, password: 'password', name: 'Test User', username: 'testuser' } }

      it 'returns unprocessable entity error' do
        post :create, params: { user: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

end
