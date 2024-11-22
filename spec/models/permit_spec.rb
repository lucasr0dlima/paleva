require 'rails_helper'

RSpec.describe Permit, type: :model do
  describe '#valid?' do
    it 'false when email is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      permit = place.permits.build(cpf: "99286956100")

      permit.valid?

      expect(permit.errors).to include :email
    end

    it 'false when cpf is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      permit = place.permits.build(email:"caio.rocha@gmail.com")

      permit.valid?

      expect(permit.errors).to include :cpf
    end

    it 'false when restaurant is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      permit = Permit.new(email:"caio.rocha@gmail.com", cpf: "99286956100")

      permit.valid?

      expect(permit.errors).to include :restaurant
    end   
  end
end
