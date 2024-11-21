class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :last_name, :cpf, presence: true
  has_one :restaurant
  has_many :dishes
  has_many :beverages
  has_many :products
  validate :cpf_check
  before_validation :permit_check

  enum :role, {:admin=>0, :regular=>5}

  private

  def cpf_check
    errors.add(:cpf, "inválido") unless CPF.valid?(cpf)
  end

  def permit_check
    if Permit.where("email like ? AND cpf like ?", self.email, self.cpf).any? && !self.restaurant.present?
      permit = Permit.find_by! email: self.email

      self.restaurant = permit.restaurant

      self.role = "regular"
    end
  end
end
