class Admin::CategoriesController < ApplicationController
  def index
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
  end

  def new
    @category = Category.new
  end

  def create
    Category.create category_params
    redirect_to admin_categories_path
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
