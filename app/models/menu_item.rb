class MenuItem < ApplicationRecord
  belongs_to :product
  belongs_to :menu
  validates :product, uniqueness: { scope: :menu }
end
