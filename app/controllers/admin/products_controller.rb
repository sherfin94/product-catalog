class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create product_params
    categories = Category.where id: params[:category_ids]
    categories.each do |category|
      category.products.push product
    end
    redirect_to admin_products_path
  end

  def destroy
   product = Product.find params[:id]
   product.destroy
   redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
