class HierarchicallyOrderedCategoriesQuery
  def all
    nested_set_options(non_empty_categories) do |category|
      slice_name_level_and_id(category)
    end
    .collect(&:first)
  end

  private

  def non_empty_categories
    NonEmptyCategoriesQuery.new.all
  end

  def slice_name_level_and_id(category)
    OpenStruct.new(
      name: category.name,
      level: category.level,
      id: category.id,
      parent_id: category.parent_id
    )
  end

  def nested_set_options(categories, &block)
    ActionController::Base
      .helpers
      .nested_set_options(categories, &block)
    end
end
