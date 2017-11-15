class Admin::CategoriesController < ApplicationController
  def index
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.create category_params
    parent = Category.find_by(id: category_params[:parent_id])
    category.move_to_child_of parent unless parent.nil?
    flash[:success] = 'Category Created'
    redirect_to admin_categories_path
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    flash[:success] = 'Category deleted'
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
