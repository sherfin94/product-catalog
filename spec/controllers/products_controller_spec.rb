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

    it 'uses NonEmptyCategoriesQuery to obtain list of non-empty categories
      and passes them to nested_set_options helper method, and assigns the
      collection of first elements of the result to
      @hierarchically_ordered_categories' do

      place_holder_non_empty_categories_list = Array.new(3) do
        FactoryBot.build :category
      end

      expect_any_instance_of(NonEmptyCategoriesQuery).to receive(:all)
        .and_return(place_holder_non_empty_categories_list)

      place_holder_nested_set_options_result =
        [['place', 1], ['holder', 2]]

      expect(ActionController::Base.helpers)
        .to receive(:nested_set_options)
        .with(place_holder_non_empty_categories_list)
        .and_return(place_holder_nested_set_options_result)

      expected_result = 'place_holder_final_result'
      expect(place_holder_nested_set_options_result)
        .to receive(:collect)
        .and_return(expected_result)

      get :index

      expect(assigns(:hierarchically_ordered_categories))
        .to eq expected_result
    end
  end
end
