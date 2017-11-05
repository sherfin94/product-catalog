require 'rails_helper'

describe NonEmptyCategoriesQuery do
  describe '#all' do
    before(:each) do
      @categories = Array.new(3) { FactoryBot.create :category }
      @categories.first(2).each do |category|
        product = FactoryBot.create :product
        category.products.push product
      end
    end

    it 'fetches all non-empty categories' do
      expected_result = @categories.first(2)
      result = NonEmptyCategoriesQuery.new.all

      expect(result).to eq expected_result
    end

    it 'considers parent categories of non-empty categories as non-empty' do
      @categories.second.move_to_child_of @categories.third
      expected_result = @categories
      result = NonEmptyCategoriesQuery.new.all

      expect(result).to match_array(expected_result)
    end
  end
end
