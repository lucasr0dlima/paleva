require 'rails_helper'

describe 'usuário adiciona tags à produtos' do
  it 'depois de adicionar uma tag, a partir da tela de criação' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Nova Tag"
    end

    expect(page).to have_content "Nova Tag"
    expect(page).to have_content "Nome"
  end

  it 'depois de adicionar uma tag, com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Nova Tag"
    end
    fill_in "Nome", with: "Premium"
    click_on "Salvar"
    click_on "Bebidas"
    within("##{beverage.id}") do
      click_on "Nova Tag"
    end

    page.has_select? "Selecione a Tag", options:["Premium"]
  end

  it 'a partir da tela de adição de tags' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
      click_on "Nova Tag"
    end

    expect(page).to have_field "Selecione a Tag"
  end

  it 'do tipo prato, com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
    tag = Tag.create!(name:"Apimentado")

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
      click_on "Nova Tag"
    end
    select tag.name, from: "Selecione a Tag"
    click_on "Adicionar"

    within("##{dish.id}") do
      expect(page).to have_content tag.name
    end
  end

  it 'do tipo bebida, com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    tag = Tag.create!(name:"Refrigerante")

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
      click_on "Nova Tag"
    end
    select tag.name, from: "Selecione a Tag"
    click_on "Adicionar"

    within("##{beverage.id}") do
      expect(page).to have_content tag.name
    end
  end
end