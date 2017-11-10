class Products::FilteredController < ApplicationController
  def index
    query_object = ProductsUnderCategoriesQuery.new params[:categories].split.map &:to_i
    @products = query_object.all
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
    @checked_category_ids = params[:categories].split.map &:to_i
  end
end
