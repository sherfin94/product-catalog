require 'rails_helper'

RSpec.describe "admin/categories/index.html.slim", type: :view do
  it 'displays the names of all the available catgories' do
    dummy_names = %w[some sample words for testing purpose]
    categories = []
    dummy_names.each do |dummy_name|
      categories.push FactoryBot.create :category, name: dummy_name
    end
    assign :hierarchically_ordered_categories, categories

    render

    expect(rendered).to include(*dummy_names)
  end
end
