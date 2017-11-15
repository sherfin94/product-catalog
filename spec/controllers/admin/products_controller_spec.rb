require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @products will all products' do
      products = Array.new(5) { FactoryBot.create :product }
      get :index
      expect(assigns(:products)).to match_array products
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'passes an instance of Product through @product' do
      get :new
      expect(assigns(:product)).to be_instance_of Product
    end
  end

  describe "POST #create" do
    before(:each) do
      @product_params = FactoryBot.attributes_for :product
    end

    it 'creates a new Product' do
      expect {
        post :create, params: { product: @product_params }
      }.to change(Product, :count).by 1
    end

    it 'pushes the product into the product list of each category id passed' do
      categories = Array.new(2) { FactoryBot.create :category }
      post :create, params: {
        product: @product_params,
        category_ids: categories.pluck(:id)
      }
      categories.each &:reload
      expect(categories.first.products).to include(Product.last)
      expect(categories.second.products).to include(Product.last)
    end

    it 'redirects to admin_products_path' do
      post :create, params: { product: @product_params }
      expect(response).to redirect_to admin_products_path
    end

    it 'sets flash[:success] when a product is created' do
      post :create, params: { product: @product_params }
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @product = FactoryBot.create :product
    end

    it 'deletes the product corresponding to the id passed' do
      expect {
        delete :destroy, params: { id: @product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to Admin::Products#index' do
      delete :destroy, params: { id: @product.id }

      expect(response).to redirect_to admin_products_path
    end
  end

end
