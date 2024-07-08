class CreateFlavors < ActiveRecord::Migration[7.1]
  def change
    create_table :flavors do |t|
      t.string :name
      t.references :tasting, foreign_key: true

      t.timestamps
    end
  end
end
