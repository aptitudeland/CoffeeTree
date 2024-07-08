class AddUserAndCoffeeReferencesToUserCoffee < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_coffees, :user, null: false, foreign_key: true
    add_reference :user_coffees, :coffee, null: false, foreign_key: true
  end
end
