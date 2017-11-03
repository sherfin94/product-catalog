require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @products with details of products' do
      products = Array.new(5) { FactoryBot.create :product }
      get :index
      expect(assigns(:products)).to eq products
    end

    it 'assigns @categories with details of categories' do
      categories = Array.new(5) { FactoryBot.create :category }
      get :index
      expect(assigns(:categories)).to eq categories
    end
  end
end
