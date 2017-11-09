require 'rails_helper'

def stubbed_products(names, descriptions, prices)
  names.zip(descriptions, prices).map do |name, description, price|
    FactoryBot.build_stubbed(
      :product,
      name: name,
      description: description,
      price: price
    )
  end
end

RSpec.describe 'products/index.html.slim', type: :view do
  before(:each) do
    @product_names = %w[something jacket pen tie bottle]
    @product_descriptions = %w[lorem ipsum dolor sit amet]
    @product_prices = %w[2.45 6.43 0.3 1.9 10.99]
    assign :products, stubbed_products(
      @product_names,
      @product_descriptions,
      @product_prices
    )
    @category_names = %w[electronics clothing makeup]
    @categories = @category_names.map do |category_name|
      FactoryBot.build_stubbed :category, name: category_name
    end
    assign :hierarchically_ordered_categories, @categories
  end

  it 'displays all the product names, descriptions and prices' do
    render

    @product_names.zip(
      @product_descriptions,
      @product_prices
    ).each do |name, description, price|
      expect(rendered).to include(name)
      expect(rendered).to include(description)
      expect(rendered).to include(price)
    end
  end

  it 'displays all the categories' do
    render

    @category_names.each { |name| expect(rendered).to include(name) }
  end
end
