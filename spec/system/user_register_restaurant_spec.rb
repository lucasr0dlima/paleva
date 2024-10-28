require 'rails_helper'

describe 'usuário registra restaurante' do
  it 'após criar conta' do
    # Arrange
    
    # Act
    visit root_path
    click_on "Criar conta"

    fill_in "E-mail", with: "caio.sampaio@gmail.com"
    fill_in "Senha", with: "123456123456"
    fill_in "Confirme sua senha", with: "123456123456"
    fill_in "CPF", with: "57136336163"
    fill_in "Nome", with: "Caio"
    fill_in "Sobrenome", with: "Sampaio"
    within('.actions') do
      click_on "Criar conta"  
    end
      
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Registre seu restaurante'
  end

  it 'após ser redirecionado ao tentar acessar outra tela' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: "57136336163")
    
    # Act
    login_as(user)
    visit root_path
    click_on "Pratos"

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Registre seu restaurante'
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: "57136336163")
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Registre seu restaurante'
    fill_in "Nome Fantasia", with: 'TIM'
    fill_in "Função Social", with: 'TIM Ltda'
    fill_in "CNPJ", with: "E67A879U2DOS80"
    fill_in "Endereço Completo", with: 'Rua São Pedro 1234, São Paulo/SP'
    fill_in "Telefone", with: "12345678911"
    within('.register_button') do
      click_on "Registrar Restaurante"
    end

    # Assert
    expect(page).to have_content "Restaurante criado com sucesso"
    expect(current_path).to eq root_path
    expect(page).not_to have_content 'Registre seu restaurante'
  end

  it 'com informações incompletas' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: "57136336163")
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Registre seu restaurante'
    fill_in "Nome Fantasia", with: ''
    fill_in "Função Social", with: ''
    fill_in "CNPJ", with: ""
    fill_in "Endereço Completo", with: ''
    fill_in "Telefone", with: ""
    within('.register_button') do
      click_on "Registrar Restaurante"
    end

    # Assert
    expect(page).to have_content "Informações Incompletas"
  end

  it 'e vê os detalhes na tela inicial' do
    # Arrange
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: "57136336163")
    place = Restaurant.new(brand_name: 'CLARO', corporate_name: 'Claro ltda', cnpj: "XZ99QR9ILGDO23", address: 'Rua São João 777, RIO/RJ', phone_number: "9197777779", user: user, code: "JM1VHG")

    # Act
    login_as(user)
    visit root_path

    # Assert
    expect(page).to have_content place.brand_name
    expect(page).to have_content place.corporate_name
    expect(page).to have_content place.cnpj
    expect(page).to have_content place.address
    expect(page).to have_content place.phone_number
    expect(page).to have_content place.code

  end
  
end