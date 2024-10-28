class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :last_name, :cpf, presence: true
  has_one :restaurant
  has_many :dishes
  validate :cpf_check

  private

  def cpf_check
    errors.add(:cpf, "inválido") unless CPF.valid?(cpf)
  end
end
