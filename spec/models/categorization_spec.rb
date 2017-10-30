require 'rails_helper'

RSpec.describe Categorization, type: :model do
  it { should belong_to :category }
  it { should belong_to :product }
  describe 'validation' do
    it 'validates the uniqueness of each product in a category' do
      subject.product = FactoryBot.create :product
      is_expected.to validate_uniqueness_of(:product_id).scoped_to(:category_id)
    end
  end
end
