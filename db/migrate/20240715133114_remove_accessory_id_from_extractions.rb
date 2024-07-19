class RemoveAccessoryIdFromExtractions < ActiveRecord::Migration[7.1]
  def change
    remove_column :extractions, :accessory_id, :integer
  end
end
