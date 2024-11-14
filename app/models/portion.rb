class Portion < ApplicationRecord
  belongs_to :product
  validates :description, :price, presence: true

  def dollars
    self.price / 100
  end
end
