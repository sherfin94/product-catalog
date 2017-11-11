require 'rails_helper'

RSpec.describe "admin/index.html.slim", type: :view do
  it "displays links with text 'Categories' and 'Products'" do
    render
    expect(rendered).to match (/<a.*Categories<\/a>/)
    expect(rendered).to match (/<a.*Products<\/a>/)
  end
end
