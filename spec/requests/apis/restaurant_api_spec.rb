require 'rails_helper'

describe 'Restaurant API' do
  context 'orders index' do
    it 'returns status 200' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

      get api_v1_restaurant_orders_path(place)

      expect(response).to have_http_status(200)
    end

    it 'returns all orders' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
      Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
      Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place)

      get api_v1_restaurant_orders_path(place)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "João Souza"
      expect(json_response[1]["name"]).to eq "Pedro Souza"
    end

    it 'returns 404 status if invalid id' do
      user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
      place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')

      get '/api/v1/restaurants/999/orders'

      expect(response).to have_http_status(404)
    end
  end

  it 'returns all pending orders' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place)
    Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place)
    Order.create!(name: "Caio Souza", phone_number: "967234134", email: "aio.souza@gmail.com", cpf: "48919882665", restaurant: place, status: 'canceled')

    get pending_api_v1_restaurant_orders_path(place)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.length).to eq 2
    expect(json_response[0]["name"]).to eq "João Souza"
    expect(json_response[1]["name"]).to eq "Pedro Souza"
  end

  it 'returns all orders in preparation' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, status: 'preparation')
    Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place, status: 'preparation')
    Order.create!(name: "Caio Souza", phone_number: "967234134", email: "aio.souza@gmail.com", cpf: "48919882665", restaurant: place, status: 'pending')

    get preparation_api_v1_restaurant_orders_path(place)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.length).to eq 2
    expect(json_response[0]["name"]).to eq "João Souza"
    expect(json_response[1]["name"]).to eq "Pedro Souza"
  end

  it 'returns all canceled orders' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, status: 'canceled')
    Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place, status: 'canceled')
    Order.create!(name: "Caio Souza", phone_number: "967234134", email: "aio.souza@gmail.com", cpf: "48919882665", restaurant: place, status: 'pending')

    get canceled_api_v1_restaurant_orders_path(place)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.length).to eq 2
    expect(json_response[0]["name"]).to eq "João Souza"
    expect(json_response[1]["name"]).to eq "Pedro Souza"
  end

  it 'returns all ready orders' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, status: 'ready')
    Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place, status: 'ready')
    Order.create!(name: "Caio Souza", phone_number: "967234134", email: "aio.souza@gmail.com", cpf: "48919882665", restaurant: place, status: 'pending')

    get ready_api_v1_restaurant_orders_path(place)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.length).to eq 2
    expect(json_response[0]["name"]).to eq "João Souza"
    expect(json_response[1]["name"]).to eq "Pedro Souza"
  end

  it 'returns all delivered orders' do
    user = User.create!(email: 'caio@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
    place = Restaurant.create!(brand_name: 'TIM', corporate_name: 'Tim ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: user, code: 'EYFFKJ')
    Order.create!(name: "João Souza", phone_number: "812205154", email: "joao.souza@gmail.com", cpf: "06939081658", restaurant: place, status: 'delivered')
    Order.create!(name: "Pedro Souza", phone_number: "812234154", email: "pedro.souza@gmail.com", cpf: "14032062102", restaurant: place, status: 'delivered')
    Order.create!(name: "Caio Souza", phone_number: "967234134", email: "aio.souza@gmail.com", cpf: "48919882665", restaurant: place, status: 'ready')

    get delivered_api_v1_restaurant_orders_path(place)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.length).to eq 2
    expect(json_response[0]["name"]).to eq "João Souza"
    expect(json_response[1]["name"]).to eq "Pedro Souza"
  end
end