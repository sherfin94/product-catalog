class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    Product.create product_params
    redirect_to admin_products_path
  end

  def destroy
   product = Product.find params[:id]
   product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
