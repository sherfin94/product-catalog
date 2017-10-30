class Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :product
  validates_uniqueness_of :product_id, scope: :category_id
end
