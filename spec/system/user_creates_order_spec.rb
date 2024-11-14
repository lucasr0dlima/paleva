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

  # it 'a partir da tela de finalização de pedido' do
  #   user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
  #   place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  #   dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
  #   Tag.create!(name:"Apimentado")
  #   beverage = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')
  #   portion = beverage.portions.create!(description: "500ml", price: "R$20,00", product: beverage)
  #   menu = Menu.create!(name:"Jantar", restaurant: place)
  #   menu.menu_items.create!(product: beverage)

  #   login_as(user)
  #   visit root_path
  #   click_on menu.name
  #   within("##{beverage.id}") do
  #     click_on "Adicionar a pedido"
  #   end
  #   click_on menu.name
  #   within("##{dish.id}") do
  #     click_on "Adicionar a pedido"
  #   end
  #   click_on "Finalizar Pedido"

  #   expect(page).to have_field "Nome"
  #   expect(page).to have_field "Telefone"
  #   expect(page).to have_field "E-mail"
  #   expect(page).to have_field "CPF"
  # end

  # order_controller!
end