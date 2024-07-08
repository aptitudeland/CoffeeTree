class RemoveCoffeeFromVariety < ActiveRecord::Migration[7.1]
  def change
    remove_reference :varieties, :coffee, null: false, foreign_key: true
  end
end
