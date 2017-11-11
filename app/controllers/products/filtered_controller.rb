class Products::FilteredController < ApplicationController
  def index
    query_object = FilterProductsByCategoriesQuery.new category_ids_in_params
    @products = query_object.all
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.non_empty
    @checked_category_ids = category_ids_in_params
  end

  private

  def category_ids_in_params
    params[:categories].split.map(&:to_i)
  end
end
