class Category < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true
  has_many :categorizations
  has_many :products, through: :categorizations, dependent: :destroy
end
