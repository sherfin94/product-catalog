class Admin::CategoriesController < ApplicationController
  def index
    @hierarchically_ordered_categoryies =
      HierarchicallyOrderedCategoriesQuery.new.all
  end
end
