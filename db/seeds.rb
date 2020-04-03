require 'resolv-replace'
require 'open-uri'
require 'json'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
cocktail_serialized = open(url).read
cocktail = JSON.parse(cocktail_serialized)

puts "Creating Ingredients"
cocktail['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

puts "Create Admin"
admin = User.new
admin.email = "verena.mller@gmail.com"
admin.username = "Vronski"
admin.password = "123456789"
admin.save

puts "Creating Long Island Ice Tea"
file = URI.open('https://images.unsplash.com/photo-1510626176961-4b57d4fbad03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80')
ice = Cocktail.new(name: "Long Island Iced Tea", user_id: 1)
ice.photo.attach(io: file, filename: '2.png', content_type: 'image/png')
ice.save

puts "Creating Manhattan"
file = URI.open('https://images.unsplash.com/photo-1576874240748-795e3bfa4c5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
manhattan = Cocktail.new(name: "Manhattan", user_id: 1)
manhattan.photo.attach(io: file, filename: '3.png', content_type: 'image/png')
manhattan.save

puts "Creating daiquiri"
file = URI.open('https://images.unsplash.com/photo-1566733971017-f6a46e832e95?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
daiquiri = Cocktail.new(name: "Daiquiri", user_id: 1)
daiquiri.photo.attach(io: file, filename: '4.png', content_type: 'image/png')
daiquiri.save

puts "Creating margarita"
file = URI.open('https://images.unsplash.com/photo-1500420986994-e4ad8f630fee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
margarita = Cocktail.new(name: "Margarita", user_id: 1)
margarita.photo.attach(io: file, filename: '5.png', content_type: 'image/png')
margarita.save

puts "bloody mary"
file = URI.open('https://images.unsplash.com/photo-1571045741139-afb07c44b2c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80')
bloody = Cocktail.new(name: "Bloody Mary", user_id: 1)
bloody.photo.attach(io: file, filename: '6.png', content_type: 'image/png')
bloody.save

puts "Creating some fake reviews"
10.times do
  @rating = rand(1..5)
  @cocktail_id = rand(1..6)
  Review.create(rating: @rating, user_id: 1, cocktail_id: @cocktail_id)
end

puts "Finished"
