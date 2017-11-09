class ProductsController < ApplicationController
  def index
    @products = Product.all
    @hierarchically_ordered_categories = hierarchically_ordered_categories
  end

  private

  def non_empty_categories
    NonEmptyCategoriesQuery.new.all
  end

  def slice_name_level_and_id(category)
    OpenStruct.new(
      name: category.name,
      level: category.level,
      id: category.id
    )
  end

  def hierarchically_ordered_categories
    ActionController::Base
      .helpers
      .nested_set_options(non_empty_categories) do |category|
        slice_name_level_and_id(category)
      end
      .collect(&:first)
  end
end
