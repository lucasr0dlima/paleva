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
      click_on "Criar conta"
    end

    # Assert
    expect(page).to have_content "Restaurante criado com sucesso"
    expect(current_path).to eq root_path
    expect(page).not_to have_content 'Registre seu restaurante'
  end
end