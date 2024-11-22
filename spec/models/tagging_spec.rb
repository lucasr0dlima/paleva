require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe '#valid?' do
    it 'false when tag is empty' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
      tagging = beverage.taggings.build

      tagging.valid?

      expect(tagging.errors).to include :tag
    end

    it 'false when product is empty' do
      tag = Tag.create!(name:"Refrigerante")
      tagging = Tagging.new(tag: tag)

      tagging.valid?

      expect(tagging.errors).to include :product
    end
  end
end
