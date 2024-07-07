class RemoveNullFalseFromCoffeeIdInVarieties < ActiveRecord::Migration[7.1]
  def change
    change_column_null :varieties, :coffee_id, true
  end
end
