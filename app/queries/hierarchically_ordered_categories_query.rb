class HierarchicallyOrderedCategoriesQuery
  def all
    nested_set_options(Category, &:slice_name_level_and_id)
      .collect(&:first)
      .compact
  end

  def non_empty
    non_empty_category_ids = non_empty_categories.pluck :id
    nested_set_options(Category) do |category|
      if non_empty_category_ids.include? category.id
        slice_name_level_and_id(category)
      end
    end
      .collect(&:first)
      .compact
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
