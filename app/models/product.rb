class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_many :categorizations
  has_many :categories, through: :categorizations
end
