class FilterProductsByCategoriesQuery
  def initialize(category_ids = [])
    @category_ids = category_ids
  end

  def all
    categories_and_their_descendants.uniq.map(&:products).flatten.uniq
  end

  private

  def categories
    Array.wrap Category.where(id: @category_ids).eager_load :children
  end

  def categories_with_parents_filtered_out
    loaded_categories = categories
    loaded_categories.select do |category|
      (loaded_categories & category.children).empty?
    end
  end

  def categories_and_their_descendants
    categories_with_parents_filtered_out.map(&:self_and_descendants).flatten
  end
end
