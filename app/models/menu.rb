class Menu < ApplicationRecord
  has_many :menu_items
  has_many :products, through: :menu_items
  belongs_to :restaurant
end
