require 'rails_helper'

RSpec.describe Products::FilteredController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      @category = FactoryBot.create :category
      @products = Array.new(5) do
        FactoryBot.create :product, categories: [@category]
      end
    end
    it 'returns http success' do
      params = { categories: [@category.id] }
      get :index, params: params
      expect(response).to have_http_status(:success)
    end

    it 'creates ProductsUnderCategoriesQuery with the category ids
      passed, and returns the result in JSON format' do
      new_category = FactoryBot.create :category
      dummy_products_list = [{ name: 'test' }]
      query_object = ProductsUnderCategoriesQuery.new

      expect(ProductsUnderCategoriesQuery).to receive(:new)
        .with([@category.id.to_s, new_category.id.to_s]).and_return query_object
      expect(query_object).to receive(:all).and_return dummy_products_list

      params = { categories: "#{@category.id} #{new_category.id}" }
      get :index, params: params
      result = response.body
      expected_result = { products: dummy_products_list }.to_json

      expect(result).to eq expected_result
    end
  end
end
