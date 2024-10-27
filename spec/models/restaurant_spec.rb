require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '#valid?' do
  
    context 'presence' do
      it 'false when brand name is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :brand_name
      end
      
      it 'false when corporate name is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :corporate_name
      end

      it 'false when cnpj is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :cnpj
      end

      it 'false when address is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :address
      end

      it 'false when phone number is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :phone_number
      end

      it 'false when email is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :email
      end

      # add work hours validation
  
      it 'false when code is empty' do
        place = Restaurant.new

        place.valid?
        result = place.code.present?

        expect(result).to be true 
      end

      it 'false when user is empty' do
        place = Restaurant.new

        place.valid?

        expect(place.errors).to include :user_id 
      end
    end
    
    it 'false when code is not unique' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')

      second_user = User.create!(email: 'joao@gmail.com', password: '1266666', name: 'João', last_name: 'Soares', cpf: '"02611112304"')

      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

      place = Restaurant.new(brand_name: 'CLARO', corporate_name: 'Claro ltda', cnpj: "XZ99QR9ILGDO23", address: 'Rua São João 777, RIO/RJ', phone_number: "9197777779", user: second_user, code: 'EYFFKJ')
      
      # Act
      place.valid?

      # Assert
      expect(place.errors).to include :code
    end

    it 'false when code is more than 6 digits' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.new(brand_name: 'CLARO', corporate_name: 'Claro ltda', cnpj: "XZ99QR9ILGDO23", address: 'Rua São João 777, RIO/RJ', phone_number: "9197777779", user: user, code: 'EYFFKJ8')

      # Act
      place.valid?

      # Assert
      expect(place.errors).to include :code
    end

    it 'false when code is not alphanumeric' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.new(brand_name: 'CLARO', corporate_name: 'Claro ltda', cnpj: "XZ99QR9ILGDO23", address: 'Rua São João 777, RIO/RJ', phone_number: "9197777779", user: user, code: 'EYF&KJ')

      # Act
      place.valid?

      # Assert
      expect(place.errors).to include :code
    end

    it 'false when phone number is not 10/11' do
      place_a = Restaurant.new(phone_number: '9191')
      place_b = Restaurant.new(phone_number: '123456789abcdefg')

      place_a.valid?
      place_b.valid?

      expect(place_a.errors).to include :phone_number
      expect(place_b.errors).to include :phone_number
    end

    it 'false when cnpj is invalid' do
      place = Restaurant.new(cnpj: '123113120')

      place.valid?

      expect(place.errors).to include :cnpj
    end
    
  end
end
