class Permit < ApplicationRecord
  belongs_to :restaurant
  validates :email, :cpf, presence: true
end
