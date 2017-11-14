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

    it "returns http success" do
      post :create, params: { product: @product_params }
      expect(response).to have_http_status(:success)
    end

    it 'creates a new Product' do
      expect {
        post :create, params: { product: @product_params }
      }.to change(Product, :count).by 1
    end
  end

  describe "DELETE #destroy" do
    pending "returns http success" do
      delete :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
