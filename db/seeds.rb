# db/seeds.rb
require 'csv'

puts "Destroying all previous tastings"
Tasting.destroy_all

puts "Destroying all previous extractions"
Extraction.destroy_all

puts "Destroying all user_coffees"
UserCoffee.destroy_all

puts "Destroying all previous accessories"
Accessory.destroy_all

puts "Destroying all coffee_varieties"
CoffeeVariety.destroy_all

puts "Destroying all previous coffees"
Coffee.destroy_all

# Create an admin user if it doesn't already exist
unless User.exists?(email: 'admin@example.com')
  admin_user = User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    nickname: 'admin'
  )
  puts "Created Admin user with EMAIL: admin@example.com and PASSWORD: password"
else
  admin_user = User.find_by(email: 'admin@example.com')
  puts "Admin user already exists with EMAIL: admin@example.com and PASSWORD: password"
end

accessories = [
  { name: 'Santos', accessory_type: 'Grinder', grinder_min: 0, grinder_max: 30, user: admin_user },
  { name: 'Sage Integrated Grinder', accessory_type: 'Grinder', default: true, grinder_min: 0, grinder_max: 30, user: admin_user },
  { name: 'Sage Express Impress', accessory_type: 'Espresso', default: true, user: admin_user },
  { name: 'My Drip Coffee Maker', accessory_type: 'Drip coffee', user: admin_user },
  { name: 'Origamy Cone', accessory_type: 'Pour-Over', user: admin_user },
  { name: 'Melita Brown Filter', accessory_type: 'Filter', user: admin_user },
  { name: 'Sage Integrated Tamper', accessory_type: 'Tamper', default: true, user: admin_user },
  { name: 'My Tamper', accessory_type: 'Tamper', user: admin_user },
  { name: 'My Sage DOUBLE Basket', accessory_type: 'Basket', default: true, user: admin_user },
  { name: 'My Sage SIMPLE Basket', accessory_type: 'Basket', user: admin_user },
  { name: 'My Repartitor', accessory_type: 'Distribution Tool', user: admin_user },
  { name: 'My WDT', accessory_type: 'Distribution Tool', user: admin_user },
  { name: 'My Basic Kettle', accessory_type: 'Kettle', user: admin_user }
]

accessories.each do |accessory|
  Accessory.create!(accessory)
end

puts "Created accessories for the admin user"

cof = Coffee.new(
  name: "Alejandro Marin / BR300",
  roaster: "Kultivar",
  roasting_date: "2024-02-05",
  process: "Naturel Anaérobie",
  country: "CO",
  region: "Finca Patio Bonito, Salento, Qunidlo",
  altitude: 1650
)
cof.varieties.push(Variety.find_by(name: 'Bourbon'))
cof.save!

cof = Coffee.new(
  name: "Farms Yungas",
  roaster: "Shouka",
  roasting_date: "2023-09-06",
  process: "Lavée",
  country: "BO",
  region: "La Paz",
  altitude: 1660
)
cof.varieties.push(Variety.find_by(name: 'Caturra'))
cof.varieties.push(Variety.find_by(name: 'Typica'))
cof.varieties.push(Variety.find_by(name: 'Catuai'))
cof.save!

puts "Created coffees"

puts "SEEDS COMPLETE"
