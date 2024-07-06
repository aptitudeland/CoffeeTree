class CreateAccessories < ActiveRecord::Migration[7.1]
  def change
    create_table :accessories do |t|
      t.string :type
      t.string :name
      t.boolean :default
      t.text :comments
      t.integer :grinder_min
      t.integer :grinder_max
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
