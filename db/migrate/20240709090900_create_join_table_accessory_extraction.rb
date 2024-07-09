class CreateJoinTableAccessoryExtraction < ActiveRecord::Migration[7.1]
  def change
    create_join_table :accessories, :extractions do |t|
      t.index [:accessory_id, :extraction_id], unique: true
      t.index [:extraction_id, :accessory_id]
      t.timestamps
    end
  end
end
