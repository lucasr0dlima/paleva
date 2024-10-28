class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :name, :description, presence: true
end
