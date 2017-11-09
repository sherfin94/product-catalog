class ProductsController < ApplicationController
  def index
    @products = Product.all
    @hierarchically_ordered_categories =
      HierarchicallyOrderedCategoriesQuery.new.all
  end
end
