class Products::FilteredController < ApplicationController
  def index
    query_object = ProductsUnderCategoriesQuery.new params[:categories].split
    @products = query_object.all
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
  end
end
