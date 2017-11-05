class NonEmptyCategoriesQuery
  def all
    category_ids =
      Categorization
      .select('distinct category_id')
      .map(&:category_id)
    categories = Array.wrap Category.where id: category_ids
    categories.map(&:self_and_ancestors).flatten.uniq
  end
end
