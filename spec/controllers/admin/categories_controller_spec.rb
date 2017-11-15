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

  describe 'GET #new' do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'build an empty category and assigns it to @category' do
      get :new
      expect(assigns(:category)).to be_instance_of(Category)
    end
  end

  describe 'POST #create' do
    before(:each) do
      @category_params = FactoryBot.attributes_for :category
    end

    it 'creates a new Category' do
      expect {
        post :create, params: { category: @category_params }
      }.to change(Category, :count).by 1
    end

    it 'redirects to Admin::Categories#index' do
      post :create, params: { category: @category_params }

      expect(response).to redirect_to admin_categories_path
    end

    it 'moves the created category to child of given parent' do
      parent = FactoryBot.create :category
      post :create, params: { category: @category_params, parent_id: parent.id }
      parent.reload
      expect(Category.last.is_descendant_of?(parent)).to be true
    end

    it 'makes the created category a root category if parent_id is
    not specified' do
      post :create, params: { category: @category_params }
      expect(Category.last.root?).to be true
    end

    it 'sends a success message through flash' do
      post :create, params: { category: @category_params }

      expect(flash[:success]).to be_present
    end

    it 'sends a failure message if ActiveRecord::RecordInvalid is raised' do
      post :create, params: { category: {invalid: 'param'} }

      expect(flash[:failure]).to be_present
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @category = FactoryBot.create :category
    end

    it 'destroys the category provided through params' do
      expect {
        delete :destroy, params: {id: @category.id}
      }.to change(Category, :count).by -1
    end

    it 'redirects to Admin::Categories#index' do
      delete :destroy, params: { id: @category.id }

      expect(response).to redirect_to admin_categories_path
    end

    it 'sends a success message through flash' do
      delete :destroy, params: { id: @category.id }

      expect(flash[:success]).to be_present
    end

    it 'sends a failure message if ActiveRecord::RecordNotFound is raised' do
      delete :destroy, params: { id: '-1' }

      expect(flash[:failure]).to be_present
    end
  end
end
