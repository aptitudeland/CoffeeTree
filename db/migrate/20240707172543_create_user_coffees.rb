class CreateUserCoffees < ActiveRecord::Migration[7.1]
  def change
    create_table :user_coffees do |t|
      t.integer :bag_weight
      t.integer :weight_left
      t.decimal :price
      t.text :personal_notes
      t.boolean :archived

      t.timestamps
    end
  end
end
