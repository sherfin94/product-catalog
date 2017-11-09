require 'rails_helper'

describe HierarchicallyOrderedCategoriesQuery do
  describe '#all' do
    it 'uses NonEmptyCategoriesQuery to obtain list of non-empty categories
      and passes them to nested_set_options helper method, and returns the
      collection of first elements of the result' do

      place_holder_non_empty_categories_list = Array.new(3) do
        FactoryBot.build :category
      end

      expect_any_instance_of(NonEmptyCategoriesQuery).to receive(:all)
        .and_return(place_holder_non_empty_categories_list)

      place_holder_nested_set_options_result =
        [['place', 1], ['holder', 2]]

      expect(ActionController::Base.helpers)
        .to receive(:nested_set_options)
        .with(place_holder_non_empty_categories_list)
        .and_return(place_holder_nested_set_options_result)

      expected_result = 'place_holder_final_result'
      expect(place_holder_nested_set_options_result)
        .to receive(:collect)
        .and_return(expected_result)

      result = described_class.new.all

      expect(result)
        .to eq expected_result
    end
  end
end
