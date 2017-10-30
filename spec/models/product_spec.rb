require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should have_many :categorizations }
  it { should have_many(:categories).through(:categorizations) }
end
