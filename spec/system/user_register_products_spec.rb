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
      expect(page).to have_content "Salada preparada com alface-romana e molho Caesar"
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
        click_on 'Editar'
      end
  
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
        click_on 'Editar'
      end
      fill_in "Nome", with: "Carbonara"
      within('form') do
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
        click_on 'Editar'
      end
      fill_in "Nome", with: ''
      within('form') do
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
        click_on 'Remover'
      end
  
      # Assert
      expect(page).not_to have_content 'Salada Caesar'
      expect(page).not_to have_content 'Salada preparada com alface-romana e molho Caesar'
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
      click_on "Pratos"
      click_on "Adicionar Prato"
  
      # Assert
      expect(page).to have_field "Nome"
      expect(page).to have_field "Descrição"
      expect(page).to have_field "Calorias"
      expect(page).to have_field "Imagem"
      expect(page).to have_button "Cadastrar"
    end
  end

end