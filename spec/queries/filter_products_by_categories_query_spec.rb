require 'rails_helper'

describe FilterProductsByCategoriesQuery do
  describe '#all' do
    before(:each) do
      @categories = Array.new(3) { FactoryBot.create :category }
      @first_category, @second_category, @third_category = @categories
      @products = Array.new(5) { FactoryBot.create :product }
      @first_category.products.push [@products.first, @products.third]
      @second_category.products.push [@products.second, @products.fourth]
      @third_category.products.push [@products.third, @products.fifth]
    end

    it 'returns all the products belonging to all categories that are passed' do
      result = described_class.new(@categories.map(&:id)).all

      expect(result).to include(*@products)
      expect(result.count).to eq @products.count
    end

    it 'returns all products belonging to the categories that are passed,
      their sub-categories and their sub-sub-categories' do
      @second_category.move_to_child_of @first_category
      @third_category.move_to_child_of @second_category
      result = described_class.new([@first_category.id]).all

      expect(result).to include(*@products)
      expect(result.count).to eq @products.count
    end

    it 'does not return the same product twice even if multiple categories
      contain the same product' do
      result = described_class.new([@first_category.id, @third_category.id]).all

      expect(result.count(@products.third)).to eq 1
    end

    it 'returns empty set if no category ids are passed' do
      result = described_class.new.all

      expect(result).to be_empty
    end

    it 'does not return the products of categories which are parents of
      any other category in params' do
      @second_category.move_to_child_of @first_category
      result = described_class.new([@first_category.id, @second_category.id]).all.pluck(:id)

      expect(result).not_to include(*@first_category.products.pluck(:id))
    end
  end
end
