require 'rails_helper'

describe 'usuário cria conta' do
  it 'a partir da tela inicial' do
    # Arrange
    
    # Act
    visit root_path
    click_on "Criar conta"

    # Assert
    expect(page).to have_content "Registrar Conta"
    expect(page).to have_field "E-mail"
    expect(page).to have_field "Senha"
    expect(page).to have_field "CPF"
    expect(page).to have_field "Nome"
    expect(page).to have_field "Sobrenome"
  end

  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on "Criar conta"

    fill_in "E-mail", with: "caio.sampaio@gmail.com"
    fill_in "Senha", with: "123456123456"
    fill_in "Confirme sua senha", with: "123456123456"
    fill_in "CPF", with: "35224091594"
    fill_in "Nome", with: "Caio"
    fill_in "Sobrenome", with: "Sampaio"
    within('.actions') do
      click_on "Criar conta"  
    end

    # Assert
    expect(page).to have_content "Bem vindo! Você realizou seu registro com sucesso"
  end

  it 'com informações incompletas' do
    # Arrange

    # Act
    visit root_path
    click_on "Criar conta"

    fill_in "E-mail", with: ""
    fill_in "Senha", with: ""
    fill_in "Confirme sua senha", with: ""
    fill_in "CPF", with: ""
    fill_in "Nome", with: ""
    fill_in "Sobrenome", with: ""
    within('.actions') do
    click_on "Criar conta"  
    end

    # Assert
    expect(page).to have_content "Não foi possível salvar usuário"
    expect(page).to have_content "E-mail não pode ficar em branco"
    expect(page).to have_content "Senha não pode ficar em branco"
    expect(page).to have_content "CPF não pode ficar em branco"
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Sobrenome não pode ficar em branco"
  end
end