require 'rails_helper'

describe 'Usuário cria cardápio' do
  it 'a partir da tela de criação' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Novo Cardápio"
    end    

    expect(page).to have_field "Nome"
    expect(page).to have_button "Cadastrar"
  end

  it 'com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Novo Cardápio"
    end
    fill_in "Nome", with: "Café da Manhã"
    click_on "Cadastrar"

    expect(current_path).to eq root_path
    expect(page).to have_content "Café da Manhã"
  end

  it 'e adiciona itens, a partir da tela de adição' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    # portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)

    login_as(user)
    visit root_path
    click_on menu.name
    click_on "Adicionar Item"

    page.has_select? "Selecione o Item", options:["Caipirinha"]
  end

  it 'e adiciona itens, com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)

    login_as(user)
    visit root_path
    click_on menu.name
    click_on "Adicionar Item"
    select beverage.name, from: "Selecione o Item"
    click_on "Adicionar"

    expect(current_path).to eq menu_path(menu)
    expect(page).to have_content "Caipirinha"
    expect(page).to have_content "500ml"
    expect(page).to have_content "R$20,00"
  end
end