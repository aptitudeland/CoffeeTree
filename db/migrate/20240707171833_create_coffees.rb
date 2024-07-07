class CreateCoffees < ActiveRecord::Migration[7.1]
  def change
    create_table :coffees do |t|
      t.string :roaster
      t.date :roasting_date
      t.string :name
      t.string :process
      t.string :country
      t.string :region
      t.decimal :latitude
      t.decimal :longitude
      t.integer :altitude_low
      t.integer :altitude_high

      t.timestamps
    end
  end
end
