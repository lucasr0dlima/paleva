require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "#valid?" do
    it 'false when order is empty' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
      portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
      menu = Menu.create!(name:"Jantar", restaurant: place)
      menu.menu_items.create!(product: beverage)
      item = OrderItem.new(portion_id: portion.id)

      item.valid?

      expect(item.errors).to include :order
    end

    it 'false when portion is empty' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
      portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
      menu = Menu.create!(name:"Jantar", restaurant: place)
      menu.menu_items.create!(product: beverage)
      order = Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
      item = order.order_items.build

      item.valid?

      expect(item.errors).to include :portion
    end
  end
end
