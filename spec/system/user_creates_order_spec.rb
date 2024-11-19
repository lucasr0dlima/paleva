require 'rails_helper'

describe 'Usuário faz um pedido' do
  it 'a partir da tela de adição de pedido' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00", product: beverage)
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)

    login_as(user)
    visit root_path
    click_on menu.name
    within("##{beverage.id}") do
      click_on "Adicionar a pedido"
    end

    expect(page).to have_content beverage.name
    expect(page).to have_content portion.description
  end

  it 'a partir da tela de finalização de pedido' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    # dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
    Tag.create!(name:"Apimentado")
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)

    login_as(user)
    visit root_path
    click_on menu.name
    within("##{beverage.id}") do
      within("#portion_#{portion.id}") do
        click_on "Adicionar a pedido"
      end
    end
    click_on "Finalizar Pedido"

    expect(page).to have_field "Nome"
    expect(page).to have_field "Telefone"
    expect(page).to have_field "E-mail"
    expect(page).to have_field "CPF"
  end

  it 'de um único item, com sucesso' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Tag.create!(name:"Apimentado")
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)

    login_as(user)
    visit root_path
    click_on menu.name
    within("##{beverage.id}") do
      within("#portion_#{portion.id}") do
        click_on "Adicionar a pedido"
      end
    end
    click_on "Finalizar Pedido"
    fill_in "Nome", with: "João Souza"
    fill_in "Telefone", with: "812205154"
    fill_in "E-mail", with: "joao.souza@gmail.com"
    fill_in "CPF", with: "06939081658"
    click_on "Finalizar"

    expect(current_path).to eq root_path
    expect(page).to have_content "Pedido feito com sucesso"
    expect(page).not_to have_content beverage.name
    expect(page).not_to have_content portion.description
  end

  it 'e o vê na tela de pedidos com um código alfanumérico de 8 digitos' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Tag.create!(name:"Apimentado")
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)
    order = Order.new(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
    order.order_items.build(portion_id: portion.id)
    order.code = SecureRandom.alphanumeric(8).upcase
    order.save!

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Pedidos"
    end

    expect(page).to have_content order.name
    expect(page).to have_content order.code
  end

  it 'e acessa a tela de detalhes de um pedido' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Tag.create!(name:"Apimentado")
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)
    order = Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
    order.order_items.create!(portion_id: portion.id)

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Pedidos"
    end
    click_on "Pedido #{order.code}"

    expect(page).to have_content order.name
    expect(page).to have_content order.code
    expect(page).to have_content order.phone_number
    expect(page).to have_content order.email
    expect(page).to have_content order.cpf
    expect(page).to have_content portion.description
    expect(page).to have_content portion.price
    expect(page).to have_content beverage.name
  end

  it 'e verifica o status do pedido' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Tag.create!(name:"Apimentado")
    beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
    portion = beverage.portions.create!(description: "500ml", price: "R$20,00")
    menu = Menu.create!(name:"Jantar", restaurant: place)
    menu.menu_items.create!(product: beverage)
    order = Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
    order.order_items.create!(portion_id: portion.id)

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Pedidos"
    end

    expect(page).to have_content "Aguardando confirmação"
  end
end