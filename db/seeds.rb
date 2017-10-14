# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spot.destroy_all
User.destroy_all
user_id = []
5.times do 
  user = User.create(email: Faker::Internet.email, password: 'password')
  user_id.push(user.id)
end 

s = Spot.new
s.id = 1
s.latitude = 37.7857
s.longitude = -122.4056
s.price = 2.0
s.rating = 5.0
s.user_id = user_id.sample
s.save

20.times do
  latitude = "37.#{(774929..800500).to_a.sample}".to_f
  longitude = "-122.#{(490027..399999).to_a.sample}".to_f
  Spot.create(latitude: latitude, longitude: longitude, user_id: user_id.sample, price: [1.50, 2.00, 2.50, 3.00].sample, rating: [3.50, 4.00, 4.50, 5.00].sample)
end 
