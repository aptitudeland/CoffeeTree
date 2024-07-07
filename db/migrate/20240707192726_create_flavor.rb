class CreateFlavor < ActiveRecord::Migration[7.1]
  def change
    create_table :flavor do |t|
      t.string :name
      t.references :tasting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
