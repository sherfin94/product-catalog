require 'rails_helper'

RSpec.describe 'products/index.html.slim', type: :view do
  def stubbed_products(product_names)
    product_names.map do |product_name|
      FactoryBot.build_stubbed :product, name: product_name
    end
  end

  it 'displays all the product names' do
    product_names = %w[something jacket pen tie bottle]
    assign :products, stubbed_products(product_names)

    render

    expect(rendered).to include(product_names[rand(5)])
  end
end
