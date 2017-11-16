class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all.eager_load :categories
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create! product_params
    product.categories.push Category.where id: params[:category_ids]
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
    product_update_service = ProductUpdateService.new params
    product_update_service.perform
    flash[:success] = 'Product updated'
  rescue ActiveRecord::RecordInvalid
    flash[:failure] = 'Failed to update product'
  ensure
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
