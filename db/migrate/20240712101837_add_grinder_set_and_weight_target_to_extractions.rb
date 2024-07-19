class AddGrinderSetAndWeightTargetToExtractions < ActiveRecord::Migration[7.1]
  def change
    add_column :extractions, :grinder_set, :integer
    add_column :extractions, :weight_target, :integer
  end
end
