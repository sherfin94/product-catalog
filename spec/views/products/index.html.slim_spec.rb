require 'rails_helper'

RSpec.describe 'products/index.html.slim', type: :view do
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

  it 'displays all the product names, descriptions and prices' do
    names = %w[something jacket pen tie bottle]
    descriptions = %w[lorem ipsum dolor sit amet]
    prices = %w[2.45 6.43 0.3 1.9 10.99]
    assign :products, stubbed_products(names, descriptions, prices)

    render

    names.zip(descriptions, prices).each do |name, description, price|
      expect(rendered).to include(name)
      expect(rendered).to include(description)
      expect(rendered).to include(price)
    end
  end
end
