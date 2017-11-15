class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create! product_params
    categories = Category.where id: params[:category_ids]
    categories.each do |category|
      category.products.push product
    end
    flash[:success] = 'Product created successfully'
    redirect_to admin_products_path
  rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid
    flash[:failure] = 'Product could not be created'
    redirect_to new_admin_product_path
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    flash[:success] = 'Product deleted successfully'
  rescue ActiveRecord::RecordNotFound
    flash[:failure] = 'Product not found'
  ensure
    redirect_to admin_products_path
  end

  def edit
    @product = Product.find_by id: params[:id]
  end

  def update
    product = Product.find_by id: params[:id]
    ids_of_categories_of_product = product.categories.pluck(:id).map &:to_s
    ids_of_categories_in_params = Array.wrap(params[:category_ids])
    product.categories.push Category.where id: (
      ids_of_categories_in_params - ids_of_categories_of_product
    )
    product.categories.delete(
      *(ids_of_categories_of_product - ids_of_categories_in_params)
    )
    product.update(product_params)
    flash[:success] = 'Product updated'
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
