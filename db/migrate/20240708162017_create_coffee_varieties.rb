class CreateCoffeeVarieties < ActiveRecord::Migration[7.1]
  def change
    create_table :coffee_varieties do |t|
      t.references :coffee, null: false, foreign_key: true
      t.references :variety, null: false, foreign_key: true

      t.timestamps
    end
  end
end
