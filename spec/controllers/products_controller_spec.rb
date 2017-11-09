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

    it 'assigns @hierarchically_ordered_categories with the result
      obtained from HierarchicallyOrderedCategoriesQuery query object' do
        place_holder_result = 'place_holder_result'
        allow_any_instance_of(HierarchicallyOrderedCategoriesQuery)
          .to receive(:all)
          .and_return(place_holder_result)

        get :index

        expect(assigns(:hierarchically_ordered_categories))
          .to eq place_holder_result
      end
  end
end
