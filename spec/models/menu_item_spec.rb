require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe '#valid?' do
    it 'false when product is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      menu = Menu.create!(name:"Jantar", restaurant: place)
      item = menu.menu_items.build

      item.valid?

      expect(item.errors).to include :product
    end

    it 'false when menu is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
      item = MenuItem.new(product: beverage)

      item.valid?

      expect(item.errors).to include :menu
    end

    it 'false when product is repeated in menu' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'R
      ua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
      menu = Menu.create!(name:"Jantar", restaurant: place)
      menu.menu_items.create!(product: beverage)
      item = menu.menu_items.build(product: beverage)

      item.valid?

      expect(item.errors).to include :product
    end
  end
end
