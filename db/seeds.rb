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

50.times do
  latitude = "37.#{(781730..782836).to_a.sample}".to_f
  longitude = "-122.#{(491027..495225).to_a.sample}".to_f
  Spot.create(latitude: latitude, longitude: longitude, user_id: user_id.sample)
end 
