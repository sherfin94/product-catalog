class Products::FilteredController < ApplicationController
  def index
    query_object = ProductsUnderCategoriesQuery.new params[:categories].split
    products = query_object.all
    render json: { products: products }, status: :ok
  end
end
