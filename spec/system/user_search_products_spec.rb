require 'rails_helper'

describe 'user searches products' do
  it 'from any view' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path 

    expect(page).to have_content "Buscar"
  end

  it 'and finds results' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    Dish.create!(name: 'Salada Caesar Azul', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    fill_in "Buscar Produtos", with: "Azul"
    click_on "Buscar"
    
    expect(page).to have_content "Caipirinha"
    expect(page).to have_content "Salada Caesar"
  end
end