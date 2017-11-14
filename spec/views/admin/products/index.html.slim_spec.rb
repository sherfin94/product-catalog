require 'rails_helper'

RSpec.describe "products/index.html.slim", type: :view do
  it 'displays all the products names, descriptions and prices' do
    products = Array.new(5) { FactoryBot.build :product }
    assign :products, products

    render template: 'admin/products/index.html.slim'

    expect(rendered).to include(*(products.pluck :name))
    expect(rendered).to include(*(products.pluck :description))
    expect(rendered).to include(*(products.pluck :price).map(&:to_s))
  end
end
