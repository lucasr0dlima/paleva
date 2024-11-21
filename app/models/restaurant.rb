class Restaurant < ApplicationRecord
  #add code
  belongs_to :user
  has_many :dishes
  has_many :beverages
  has_many :menus
  has_many :orders
  has_many :permits
  validates :brand_name, :corporate_name, :cnpj, :address, :phone_number, :email, 
            :code, presence: true 
  before_validation :add_email, :add_code
  validates :code, uniqueness: true
  validate :code_validation 
  validate :phone_number_validation
  validate :cnpj_validation

  private

  def add_email 
    if self.user.present?
      self.email = self.user.email unless email.present?  
    end
  end

  def add_code
    self.code = SecureRandom.alphanumeric(6).upcase unless code.present?
  end

  def add_user
    self.user = current_user unless User.present?
  end

  def code_validation
    if code.present? 
      unless code.match?(/\A[a-zA-Z0-9]*\z/) && code.length == 6 
        errors.add(:code, 'deve ser alfanumérico e conter 6 digitos.')
      end
    end
  end

  def phone_number_validation
    if phone_number.present?
      unless phone_number.to_s.size >= 10 && phone_number.to_s.size <= 11
        errors.add(:phone_number, 'deve conter 10/11 dígitos.')
      end
    end
  end

  def cnpj_validation
    if cnpj.present?
      errors.add(:cnpj, 'inválido.') unless CNPJ.valid?(cnpj)
    end
  end
end
