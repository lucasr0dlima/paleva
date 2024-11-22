class Beverage < Product
  validates :alcohol, presence: true
  def type
    'Beverage'
  end
end
