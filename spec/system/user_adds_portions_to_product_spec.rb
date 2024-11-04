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

  it 'com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
        click_on 'Editar'
    end
    click_on "Adicionar Porção"
    fill_in "Preço", with: "R$20,00"
    fill_in "Descrição", with: "Porção de 200g"
    click_on "Adicionar"
    save_page

    expect(page).to have_content "R$20,00"
    expect(page).to have_content "Porção de 200g"
  end

  it 'com informações incompletas' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
        click_on 'Editar'
    end
    click_on "Adicionar Porção"
    click_on "Adicionar"
    
    expect(page).to have_content "Falha na Adição"
  end

  it 'e vê a lista de porções adicionadas a um prato' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
    dish.portions.create!(description: "Porção de 200g", price: "R$20,00")

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
        click_on 'Porções'
    end

    expect(page).to have_content "R$20,00"
    expect(page).to have_content "Porção de 200g"
  end

  it 'e vê a lista de porções adicionadas a uma bebida' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    beverage.portions.create!(description: "500ml", price: "R$20,00")

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
        click_on 'Porções'
    end

    expect(page).to have_content "R$20,00"
    expect(page).to have_content "500ml"
  end

  it 'e edita seu preço, a partir da tela de edição' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
        click_on 'Porções'
    end
    within("##{portion.id}") do
        click_on 'Editar Preço'
    end

    expect(page).to have_field "Novo Preço"
  end

  it 'e edita seu preço, com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
        click_on 'Porções'
    end
    within("##{portion.id}") do
        click_on 'Editar Preço'
    end
    fill_in "Novo Preço", with: "R$50,00"
    click_on "Atualizar"

    expect(page).to have_content "R$50,00"
  end
end