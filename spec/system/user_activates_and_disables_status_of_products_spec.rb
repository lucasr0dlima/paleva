require 'rails_helper'

describe 'usuário vê status do produto' do
  it 'a partir do index de pratos' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    
    within("##{dish.id}") do
      expect(page).to have_content "Ativo"
    end
  end

  it 'a partir do index de bebidas' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Bebidas"
    
    within("##{beverage.id}") do
      expect(page).to have_content "Ativo"
    end
  end

  it 'e desativa uma bebida' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
      click_on "Desativar"
    end

    within("##{beverage.id}") do
      expect(page).to have_content "Desativado"
    end
  end

  it 'e reativa uma bebida' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha Azul', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{beverage.id}") do
      click_on "Desativar"
    end
    within("##{beverage.id}") do
      click_on "Ativar"
    end

    within("##{beverage.id}") do
      expect(page).to have_content "Ativo"
    end
  end

  it 'e desativa uma prato' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
      click_on "Desativar"
    end

    within("##{dish.id}") do
      expect(page).to have_content "Desativado"
    end
  end

  it 'e reativa um prato' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)

    login_as(user)
    visit root_path
    click_on "Pratos"
    within("##{dish.id}") do
      click_on "Desativar"
    end
    within("##{dish.id}") do
      click_on "Ativar"
    end

    within("##{dish.id}") do
      expect(page).to have_content "Ativo"
    end
  end
end