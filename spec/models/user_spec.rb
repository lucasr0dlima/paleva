require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      # Arrange
      
      # Act
      user = User.new
      user.valid?

      # Assert
      expect(user.errors).to include :name 
    end
    
    it 'false when last_name is empty' do
      # Arrange
      
      # Act
      user = User.new
      user.valid?

      # Assert
      expect(user.errors).to include :last_name 
    end
    
    it 'false when last_name is empty' do
      # Arrange
      
      # Act
      user = User.new
      user.valid?

      # Assert
      expect(user.errors).to include :cpf 
    end

    it 'false when cpf is invalid' do
      # Arrange
      
      # Act
      user = User.new(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '12356465')
      result = user.valid?

      # Assert
      expect(result).to be_falsey
    end
  end
end
