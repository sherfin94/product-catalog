require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @hierarchically_ordered_categoryies with the result of
      HierarchicallyOrderedCategoriesQuery#all' do
        place_holder_categories = Array.new(2) { FactoryBot.build :category }
        allow_any_instance_of(HierarchicallyOrderedCategoriesQuery)
          .to receive(:all)
          .and_return place_holder_categories

        get :index
        expect(assigns(:hierarchically_ordered_categories))
          .to eq place_holder_categories
      end
  end

end
