require 'rails_helper'

describe 'Admin cria permissão para usuário regular' do
  it 'a partir da tela de criação' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Permissões"
    end
    click_on "Nova Permissão"
    save_page

    expect(page).to have_field "E-mail"
    expect(page).to have_field "CPF"
  end

  it 'com sucesso' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

    login_as(user)
    visit root_path
    within('nav') do
      click_on "Permissões"
    end
    click_on "Nova Permissão"
    fill_in "E-mail", with: "caio.rocha@gmail.com"
    fill_in "CPF", with: "99286956100"
    save_page
    click_on "Cadastrar"
    

    expect(page).to have_content "Permissão cadastrada com sucesso"
  end

  it 'e usuário regular entra em sua conta' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    place.permits.create!(email:"caio.rocha@gmail.com", cpf: "99286956100")

    visit root_path
    within('nav') do
      click_on "Criar conta"
    end
    fill_in "E-mail", with: "caio.rocha@gmail.com"
    fill_in "Senha", with: "123456"
    fill_in "Confirme sua senha", with: "123456"
    fill_in "Nome", with: "Caio"
    fill_in "Sobrenome", with: "Rocha"
    fill_in "CPF", with: "99286956100"
    within('.actions') do
      click_on "Criar conta"  
    end

    expect(page).to have_content "Detalhes do Restaurante"
  end

  it 'e usuário regular tem página inicial limitada' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    place.permits.create!(email:"caio.rocha@gmail.com", cpf: "99286956100")
    regular = User.create!(email: "caio.rocha@gmail.com", cpf: "99286956100", password: '123456', name: 'Caio', last_name: 'Rocha')

    login_as(regular)
    visit root_path

    expect(page).not_to have_content "Pratos"
    expect(page).not_to have_content "Bebidos"
    expect(page).not_to have_content "Permissões"
    expect(page).not_to have_content "Nova Tag"
    expect(page).not_to have_content "Novo Cardápio"
    expect(page).not_to have_content "Buscar Produtos"
    expect(page).to have_content "Cardápios"
    expect(page).to have_content "Pedidos"
    expect(page).to have_content "Detalhes do Restaurante"
  end

  it 'e usuário regular tem acesso limitado' do
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place= Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    place.permits.create!(email:"caio.rocha@gmail.com", cpf: "99286956100")
    regular = User.create!(email: "caio.rocha@gmail.com", cpf: "99286956100", password: '123456', name: 'Caio', last_name: 'Rocha')

    login_as(regular)
    visit root_path
    visit beverages_path

    expect(current_path).to eq root_path
  end
end