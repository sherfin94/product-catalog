class ProductUpdateService
  def initialize(params)
    @product_id = params[:id]
    @ids_of_categories_in_params = Array.wrap(params[:category_ids])
    @product_params =
      params
      .require(:product)
      .permit(:name, :description, :price)
  end

  def perform
    fetch_product
    fetch_ids_of_categories_of_product
    add_new_categories
    remove_deselected_categories
    update_product
  end

  private

  def fetch_product
    @product = Product.find_by id: @product_id
  end

  def fetch_ids_of_categories_of_product
    @ids_of_categories_of_product =
      @product
      .categories
      .pluck(:id)
      .map(&:to_s)
  end

  def add_new_categories
    @product.categories.push Category.where id: (
      @ids_of_categories_in_params - @ids_of_categories_of_product
    )
  end

  def remove_deselected_categories
    @product.categories.delete(
      *(@ids_of_categories_of_product - @ids_of_categories_in_params)
    )
  end

  def update_product
    @product.update! @product_params
  end
end
