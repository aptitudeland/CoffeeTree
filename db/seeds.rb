# db/seeds.rb
require 'csv'

puts "Destroying all previous flavors"
Flavor.destroy_all

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

puts "Destroying all previous varieties"
Variety.destroy_all

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

flavors = [
  # Parent Flavors
  { name: 'Fruity', color_code: '#E97F81' },
  { name: 'Floral', color_code: '#EE93AC' },
  { name: 'Sweet', color_code: '#FBB21A' },
  { name: 'Nutty/Cocoa', color_code: '#B0842C' },
  { name: 'Spices', color_code: '#B45F04' },
  { name: 'Sour/Fermented', color_code: '#E9A4A6' },
  { name: 'Green/Vegetative', color_code: '#94A035' },
  { name: 'Other', color_code: '#70788F' },
  { name: 'Roasted', color_code: '#855C33' },

  # Second-Level Parent Flavors
  { name: 'Berry', color_code: '#E56772' },
  { name: 'Dried Fruit', color_code: '#E8705A' },
  { name: 'Other Fruit', color_code: '#E47E58' },
  { name: 'Citrus Fruit', color_code: '#F9D62E' },
  { name: 'Sour', color_code: '#9FA24C' },
  { name: 'Alcohol/Fermented', color_code: '#D79932' },
  { name: 'Papery/Musty', color_code: '#6F6358' },
  { name: 'Chemical', color_code: '#A4A4A7' },
  { name: 'Burnt', color_code: '#8D6243' },
  { name: 'Brown Sugar', color_code: '#D08647' },
  { name: 'Cocoa', color_code: '#7E5431' },
  { name: 'Nutty', color_code: '#C18B48' },
  { name: 'Brown Spice', color_code: '#9E592A' },

  # Specific Flavors
  { name: 'Blackberry', color_code: '#9D2438' },
  { name: 'Raspberry', color_code: '#C93C5C' },
  { name: 'Blueberry', color_code: '#7E3B72' },
  { name: 'Strawberry', color_code: '#F0575D' },
  { name: 'Raisin', color_code: '#A54D42' },
  { name: 'Prune', color_code: '#9E4B5A' },
  { name: 'Coconut', color_code: '#D1C9B6' },
  { name: 'Cherry', color_code: '#B84750' },
  { name: 'Pomegranate', color_code: '#A33A4E' },
  { name: 'Pineapple', color_code: '#F8A81B' },
  { name: 'Grape', color_code: '#854B94' },
  { name: 'Apple', color_code: '#BAD92D' },
  { name: 'Peach', color_code: '#FB9240' },
  { name: 'Pear', color_code: '#D2B948' },
  { name: 'Grapefruit', color_code: '#EEA2A0' },
  { name: 'Orange', color_code: '#F97329' },
  { name: 'Lemon', color_code: '#F5D637' },
  { name: 'Lime', color_code: '#B0D62B' },
  { name: 'Chamomile', color_code: '#DBB3B3' },
  { name: 'Rose', color_code: '#F48BA1' },
  { name: 'Molasses', color_code: '#9A572A' },
  { name: 'Maple Syrup', color_code: '#B1682C' },
  { name: 'Caramelized', color_code: '#DA7644' },
  { name: 'Vanilla', color_code: '#EFE28A' },
  { name: 'Almond', color_code: '#AB7D4A' },
  { name: 'Hazelnut', color_code: '#C68F44' },
  { name: 'Peanut', color_code: '#D1A058' },
  { name: 'Chocolate', color_code: '#633E24' },
  { name: 'Dark Chocolate', color_code: '#503229' },
  { name: 'Cinnamon', color_code: '#9C4C1E' },
  { name: 'Clove', color_code: '#84351F' },
  { name: 'Nutmeg', color_code: '#9A5532' },
  { name: 'Anise', color_code: '#B97845' },
  { name: 'Pepper', color_code: '#E8A97C' },
  { name: 'Pungent', color_code: '#A2C7D4' },
  { name: 'Acetic Acid', color_code: '#C1D0A6' },
  { name: 'Butyric Acid', color_code: '#DBE6AF' },
  { name: 'Isovaleric Acid', color_code: '#C9DC80' },
  { name: 'Citric Acid', color_code: '#DDE69F' },
  { name: 'Malic Acid', color_code: '#B5C05A' },
  { name: 'Winey', color_code: '#DBB27E' },
  { name: 'Whiskey', color_code: '#B89161' },
  { name: 'Fermented', color_code: '#AC8A5B' },
  { name: 'Overripe', color_code: '#8D774F' },
  { name: 'Olive Oil', color_code: '#7F9224' },
  { name: 'Peapod', color_code: '#C4D6A6' },
  { name: 'Fresh', color_code: '#A1BE67' },
  { name: 'Hay-like', color_code: '#D0C779' },
  { name: 'Herbal', color_code: '#97A858' },
  { name: 'Stale', color_code: '#AD9A86' },
  { name: 'Cardboard', color_code: '#BCB1A1' },
  { name: 'Papery', color_code: '#D9D4C3' },
  { name: 'Woody', color_code: '#8D6A56' },
  { name: 'Bitter', color_code: '#8A8A8D' },
  { name: 'Salty', color_code: '#C2C2C4' },
  { name: 'Medicinal', color_code: '#9999A1' },
  { name: 'Petroleum', color_code: '#56565C' },
  { name: 'Skunky', color_code: '#7D7D8E' },
  { name: 'Rubber', color_code: '#4F4F56' },
  { name: 'Pipe Tobacco', color_code: '#6F4533' },
  { name: 'Tobacco', color_code: '#4E352A' },
  { name: 'Cereal', color_code: '#B78A5C' },
  { name: 'Malt', color_code: '#B48B46' },
  { name: 'Grain', color_code: '#98753B' },
  { name: 'Brown, Roast', color_code: '#6A4A3A' },
  { name: 'Smoky', color_code: '#5E5554' },
  { name: 'Ashy', color_code: '#544D4A' },
  { name: 'Acrid', color_code: '#4D4744' }
]

flavors.each do |flavor|
  Flavor.create!(flavor)
end

puts "Created flavors"

CSV.open("lib/assets/coffee_varieties.csv", "rb", headers: true) do |varieties|
  varieties.each do |variety|
    Variety.create!(
      name: variety['name'],
      species: variety['species'],
      subname: variety['subname'],
      url: variety['url'],
      description: variety['description']
    )
  end
end

puts "Created coffee Varieties"

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
