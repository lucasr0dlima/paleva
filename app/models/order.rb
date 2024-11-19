class Order < ApplicationRecord
  has_many :order_items
  has_many :portions, through: :order_items
  before_validation :add_code
  belongs_to :restaurant

  enum :status, {:pending=>0, :preparation=>2, :canceled=>4, :ready=>6, :delivered=>8}

  def add_code
    self.code = SecureRandom.alphanumeric(8).upcase unless code.present?
  end
end
