require 'rails_helper'

describe 'usuário cadastra produto' do

  context 'pratos' do
    
    it 'do tipo prato, a partir da tela de criação' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
      # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      click_on "Adicionar Prato"
  
      # Assert
      expect(page).to have_field "Nome"
      expect(page).to have_field "Descrição"
      expect(page).to have_field "Calorias"
      expect(page).to have_field "Imagem"
      expect(page).to have_button "Cadastrar"
    end
  
    it 'do tipo prato, com sucesso' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
      # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      click_on "Adicionar Prato"
      fill_in "Nome", with: "Salada Caesar"
      fill_in "Descrição", with: "Salada preparada com alface-romana e molho Caesar"
      fill_in "Imagem", with: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg"
      click_on "Cadastrar"
  
      # Assert
      expect(page).to have_content "Salada Caesar"
      expect(page).to have_content "Prato adicionado com sucesso"
      expect(current_path).to eq dishes_path
    end
  
    it 'do tipo prato, com informações incompletas' do 
       # Arrange
       user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
       Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
       # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      click_on "Adicionar Prato"
      click_on "Cadastrar"
  
      # Assert
      expect(page).to have_content "Falha no Cadastro"
    end
  
    it 'do tipo prato, e edita o produto a partir da tela de edição' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
  
      # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      within("##{dish.id}") do
        click_on "#{dish.name}"
      end
      click_on 'Editar'
  
      # Assert
      expect(page).to have_content "Editar Salada Caesar"
    end
  
    it 'do tipo prato, e edita o produto com sucesso' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
  
      # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      within("##{dish.id}") do
        click_on "#{dish.name}"
      end
      click_on 'Editar'
      fill_in "Nome", with: "Carbonara"
      within('.register_button') do
        click_on "Editar"
      end
  
      # Assert
      expect(current_path).to eq dishes_path
      expect(page).to have_content "Carbonara"
      expect(page).to have_content "Prato editado com sucesso"
    end
  
    it 'do tipo prato, e edita o produto com informações incompletas' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
  
      # Act
      login_as(user)
      visit root_path
      click_on "Pratos"
      within("##{dish.id}") do
        click_on "#{dish.name}"
      end
      click_on 'Editar'
      fill_in "Nome", with: ''
      within('.register_button') do
        click_on "Editar"
      end
  
      # Assert
      expect(page).to have_content "Informações Incompletas"
    end
  
    it 'do tipo prato, e o deleta' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place)
  
      #Act 
      login_as(user)
      visit root_path
      click_on "Pratos"
      within("##{dish.id}") do
        click_on "#{dish.name}"
      end
      click_on 'Remover'
  
      # Assert
      expect(page).not_to have_content 'Salada Caesar'
      expect(page).to have_content "Prato Removido"
    end
     
  end
  
  context 'bebidas' do
    it 'do tipo bebida, a partir da tela de criação' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
      # Act
      login_as(user)
      visit root_path
      click_on "Bebidas"
      click_on "Adicionar Bebida"
  
      # Assert
      expect(page).to have_field "Nome"
      expect(page).to have_field "Descrição"
      expect(page).to have_content "Conteúdo álcoolico"
      expect(page).to have_field "Calorias"
      expect(page).to have_field "Imagem"
      expect(page).to have_button "Cadastrar"
    end

    it 'do tipo bebida, com sucesso' do
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
      # Act
      login_as(user)
      visit root_path
      click_on "Bebidas"
      click_on "Adicionar Bebida"
      fill_in "Nome", with: "Caipirinha"
      fill_in "Descrição", with: "Bebida alcoolica de limão e cachaça."
      fill_in "Imagem", with: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp"
      check 'Conteúdo álcoolico'
      click_on "Cadastrar"
  
      # Assert
      expect(page).to have_content "Caipirinha"
      expect(page).to have_content "Bebida adicionada com sucesso"
      expect(current_path).to eq beverages_path
    end
  
    it 'do tipo bebida, com informações incompletas' do 
      # Arrange
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
  
      # Act
     login_as(user)
     visit root_path
     click_on "Bebidas"
     click_on "Adicionar Bebida"
     click_on "Cadastrar"
  
     # Assert
     expect(page).to have_content "Falha no Cadastro"
   end
  
   it 'do tipo bebida, e edita o produto com sucesso' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    bev = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)
  
    # Act
    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{bev.id}") do
      click_on "#{bev.name}"
    end
    click_on 'Editar'
    fill_in "Nome", with: "Cerveja"
    within('.register_button') do
      click_on "Editar"
    end
  
    # Assert
    expect(current_path).to eq beverages_path
    expect(page).to have_content "Cerveja"
    expect(page).to have_content "Bebida editado com sucesso"
  end

  it 'do tipo bebida, e edita o produto com informações incompletas' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    bev = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    # Act
    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{bev.id}") do
      click_on "#{bev.name}"
    end
    click_on 'Editar'
    fill_in "Nome", with: ''
    within('.register_button') do
      click_on "Editar"
    end

    # Assert
    expect(page).to have_content "Informações Incompletas"
  end

  it 'do tipo bebida, e o deleta' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    bev = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place)

    #Act 
    login_as(user)
    visit root_path
    click_on "Bebidas"
    within("##{bev.id}") do
      click_on "#{bev.name}"
    end
    click_on 'Remover'

    # Assert
    expect(page).not_to have_content 'Caipirinha'
    expect(page).not_to have_content 'Bebida alcoolica de limão e cachaça.'
    expect(page).to have_content "Bebida Removido"
  end
end

  context 'tela de detalhes' do
    it 'e vê tela de detalhes do produto, do tipo bebida' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      bev = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: user, restaurant: place, calories: '125kcal')

      login_as(user)
      visit root_path
      click_on "Bebidas"
      within("##{bev.id}") do
        click_on "#{bev.name}"
      end

      expect(page).to have_content bev.name
      expect(page).to have_content bev.description
      expect(page).to have_content bev.calories
      expect(page).to have_content "Sim"
    end

    it 'e vê tela de detalhes do produto, do tipo prato' do
      user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      dish = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: user, restaurant: place, calories: '142kcal')

      login_as(user)
      visit root_path
      click_on "Pratos"
      within("##{dish.id}") do
        click_on "#{dish.name}"
      end

      expect(page).to have_content dish.name
      expect(page).to have_content dish.description
      expect(page).to have_content dish.calories
    end
  end

 
end