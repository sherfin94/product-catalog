class ProductsUnderCategoriesQuery
  def initialize(category_ids = [])
    @category_ids = category_ids
  end

  def all
    categories_and_their_descendants.uniq.map(&:products).flatten.uniq
  end

  private

  def categories
    Array.wrap Category.where(id: @category_ids)
  end

  def categories_and_their_descendants
    categories.map(&:self_and_descendants).flatten
  end
end
