class Portion < ApplicationRecord
  belongs_to :product
  validates :description, :price, presence: true
end
