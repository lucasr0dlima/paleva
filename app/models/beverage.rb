class Beverage < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :name, :description, :alcohol, presence: true
end
