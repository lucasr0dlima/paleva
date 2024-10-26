require 'rails_helper.rb'

describe 'após criar conta, usuário' do
  it 'faz log in' do
    # Assert
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '12356465')

    # Act
    visit root_path
    click_on "Entrar"
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    within('.actions') do
      click_on "Entrar"  
    end
    
    # Assert
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'Sair'
    expect(page).not_to have_content 'Entrar'
    expect(page).not_to have_content 'Criar conta'
    expect(current_path).to eq root_path
  end

  it 'faz log out' do
    # Assert
    user = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '12356465')
    
    # Act
    login_as(user)
    visit root_path
    click_on "Sair"
    
    # Assert
    expect(page).to have_content 'Entrar'
    expect(page).to have_content 'Criar conta'
    expect(page).not_to have_content 'Sair'
  end
end