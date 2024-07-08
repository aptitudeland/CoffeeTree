class CreateExtractions < ActiveRecord::Migration[7.1]
  def change
    create_table :extractions do |t|
      t.string :brewing_method
      t.references :coffee, null: false, foreign_key: true
      t.references :user_coffee, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :accessory, null: false, foreign_key: true
      t.decimal :weight_in
      t.integer :water_temperature
      t.integer :pre_infusion_time
      t.decimal :bloom_weight
      t.integer :extraction_time
      t.decimal :weight_out
      t.text :comment

      t.timestamps
    end
  end
end
