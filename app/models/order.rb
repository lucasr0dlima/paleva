class Order < ApplicationRecord
  has_many :portions
  has_many :products, through: :portions
end
