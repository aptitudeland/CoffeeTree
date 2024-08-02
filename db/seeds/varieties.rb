# db/seeds/varieties.rb

puts "Destroying all previous varieties"
Variety.destroy_all

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

puts "Created coffee varieties"
