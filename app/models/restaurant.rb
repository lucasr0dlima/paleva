class Restaurant < ApplicationRecord
  #add code
  belongs_to :user
  validates :brand_name, :corporate_name, :cnpj, :address, :phone_number, :user_id, presence: true 
  

  
end
