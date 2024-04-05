require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    context 'when authenticated' do
      it 'returns a list of products belonging to the current user' do
        user = create(:user,username: ENV['username'], email: ENV['email'],password: ENV['password'])
        product1 = create(:product, user: user)
        product2 = create(:product, user: user)

        # Mock authentication
        allow(controller).to receive(:authenticate_request).and_return(true)

        # Set the current user
        controller.instance_variable_set(:@current_user, user)

        # Make the request
        get :index

        # Assertions
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to match_array([product1.as_json, product2.as_json])
      end
    end

    context 'when not authenticated' do
      it 'returns an unauthorized error' do
        # Make the request without authentication
        get :index

        # Assertions
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end

  describe 'GET #show' do
  context 'when authenticated' do
    it 'returns the requested product' do
      # Create a user
      user = create(:user,username: ENV['username'], email: ENV['email'],password: ENV['password'])

      # Create a product associated with the user
      product = create(:product, user: user)

      # Mock authentication
      allow(controller).to receive(:authenticate_request).and_return(true)

      # Set the current user
      controller.instance_variable_set(:@current_user, user)

      # Make the request
      get :show, params: { id: product.id }

      # Assertions
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(product.name)
      expect(JSON.parse(response.body)['price']).to eq(product.price)
      expect(JSON.parse(response.body)['user_id']).to eq(product.user_id)
    end
  end

  context 'when not authenticated' do
    it 'returns an unauthorized error' do
      # Create a product
      user = create(:user,username: 'tom', email: ENV['email'],password: ENV['password'])

      product =  create(:product, user: user)

      # Make the request without authentication
      get :show, params: { id: product.id }

      # Assertions
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('error')
    end
  end
end
end
