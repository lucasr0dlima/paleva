require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it 'false when name is empty' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      order = Order.new(phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, note: "Sem limão.")

      order.valid?

      expect(order.errors).to include :name
    end

    it 'false when email or phone number is empty' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      order = Order.new(name: "João Souza", phone_number: "812205154", cpf: "06939081658", restaurant: place, note: "Sem limão.")
      order_b = Order.new(name: "João Souza", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, note: "Sem limão.")

      order.valid?

      expect(order.errors).not_to include :email
      expect(order.errors).not_to include :phone_number
    end

    it 'false when cpf is invalid' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      order = Order.new(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "123456789", restaurant: place, note: "Sem limão.")

      order.valid?

      expect(order.errors).to include :cpf
    end

    it 'false when restaurant is empty' do
      order = Order.new(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "123456789", note: "Sem limão.")

      order.valid?

      expect(order.errors).to include :restaurant
    end
  end
end
