class ChangeBrewingMethodToBrewingMethodIdInExtractions < ActiveRecord::Migration[6.1]
  def change
    # If this migration is redundant now, you can make it a no-op or add any missing indexes or constraints
    # that might not have been included in the previous migration.

    # Ensure the brewing_method_id column exists and add the necessary index and foreign key constraint if not already done
    unless column_exists?(:extractions, :brewing_method_id)
      add_column :extractions, :brewing_method_id, :bigint
    end

    unless index_exists?(:extractions, :brewing_method_id)
      add_index :extractions, :brewing_method_id
    end

    unless foreign_key_exists?(:extractions, :accessories, column: :brewing_method_id)
      add_foreign_key :extractions, :accessories, column: :brewing_method_id
    end
  end
end
