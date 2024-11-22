class Tag < ApplicationRecord
  has_many :taggings
  has_many :products, through: :taggings
  validates :name, presence: true
end
