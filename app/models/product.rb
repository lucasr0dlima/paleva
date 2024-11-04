class Product < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :portions

  validates :name, :description, presence: true
end