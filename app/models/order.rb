class Order < ApplicationRecord
  has_many :order_items
  has_many :portions, through: :order_items
  validates :name, presence: true
  validate :email_or_phone_number
  validate :cpf_check
  before_validation :add_code
  belongs_to :restaurant

  enum :status, {:pending=>0, :preparation=>2, :canceled=>4, :ready=>6, :delivered=>8}

  def add_code
    self.code = SecureRandom.alphanumeric(8).upcase unless code.present?
  end

  def email_or_phone_number
    if !self.email.present? && !self.phone_number.present?
      errors.add(:email, "em branco ou telefone em branco.")
    end
  end

  def cpf_check
    errors.add(:cpf, "inválido") unless CPF.valid?(self.cpf)
  end
end
