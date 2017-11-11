class ProductsController < ApplicationController
  def index
    @products = Product.all
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.non_empty
  end
end
