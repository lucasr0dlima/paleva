require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '#valid?' do
    it 'false if menu name is repeated in same restaurant' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      Menu.create!(name:"Jantar", restaurant: place)
      menu = Menu.new(name:"Jantar", restaurant: place)
      
      menu.valid?

      expect(menu.errors).to include :name
    end

    it 'false when name is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      menu = Menu.new(restaurant: place)

      menu.valid?

      expect(menu.errors).to include :name
    end

    it 'false when restaurant is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      menu = Menu.new(name:"Jantar")

      menu.valid?

      expect(menu.errors).to include :restaurant
    end
  end
end
