require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of :name }
  it { should have_many :categorizations }
  it { should have_many(:products).through :categorizations }
end
