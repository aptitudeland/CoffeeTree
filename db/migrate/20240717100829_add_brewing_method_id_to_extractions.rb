class AddBrewingMethodIdToExtractions < ActiveRecord::Migration[6.1]
  def change
    remove_column :extractions, :brewing_method, :string
    add_column :extractions, :brewing_method_id, :bigint

    add_index :extractions, :brewing_method_id
    add_foreign_key :extractions, :accessories, column: :brewing_method_id
  end
end
