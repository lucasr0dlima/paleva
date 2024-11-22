admin = User.create!(email: 'pedro@gmail.com', password: '123456', name: 'Pedro', last_name: 'Pereira', cpf: '57136336163')
place = Restaurant.create!(brand_name: 'Bom Lanche', corporate_name: 'Bom Lanche ltda', cnpj: "E67A879U2DOS80", address: 'Rua São Pedro 1234, São Paulo/SP', phone_number: "9180088008", user: admin, code: 'EYFFKJ')


caipirinha = Beverage.create!(name: 'Caipirinha', description: "Bebida alcoolica de limão e cachaça.", image: "https://i.panelinha.com.br/i1/228-q-8730-blog-caipirinha-de-limao.webp", alcohol: true,  user: admin, restaurant: place, calories: '125kcal')
salad = Dish.create!(name: 'Salada Caesar', description: "Salada preparada com alface-romana e molho Caesar", image: "https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg", user: admin, restaurant: place)
coffee = Beverage.create!(name: 'Café', description: "Bebida matinal com cafeína.", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/640px-A_small_cup_of_coffee.JPG", alcohol: false,  user: admin, restaurant: place, calories: '50kcal')

caipirinha.portions.create!(description: "250ml", price: 2000)
salad.portions.create!(description: "200g", price: 1500)
salad.portions.create!(description: "400g", price: 3000)
coffee.portions.create!(description: "50ml", price: 500)
coffee.portions.create!(description: "150ml", price: 1500)

dinner = Menu.create!(name:"Jantar", restaurant: place)
dinner.menu_items.create!(product: caipirinha)
dinner.menu_items.create!(product: salad)

breakfast = Menu.create!(name:"Café da Manhã", restaurant: place)
breakfast.menu_items.create!(product: coffee)

