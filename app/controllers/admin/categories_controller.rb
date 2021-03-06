class Admin::CategoriesController < ApplicationController
  def index
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.create! category_params
    parent = Category.find_by(id: params[:parent_id])
    category.move_to_child_of parent unless parent.nil?
    flash[:success] = 'Category Created'
  rescue ActiveRecord::RecordInvalid
    flash[:failure] = 'Failed to create category'
  ensure
    redirect_to admin_categories_path
  end

  def destroy
    category = Category.find params[:id]
    category.destroy
    flash[:success] = 'Category deleted'
  rescue ActiveRecord::RecordNotFound
    flash[:failure] = 'Category deleted'
  ensure
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
