require 'rails_helper'

describe 'Usuário adiciona porção' do
  it 'a partir da tela de adição de porções' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar Azul', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
        click_on 'Editar'
    end
    click_on "Adicionar Porção"

    expect(page).to have_field "Preço"
    expect(page).to have_field "Descrição"
  end  

end