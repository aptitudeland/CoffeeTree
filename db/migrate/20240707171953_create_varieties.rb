class CreateVarieties < ActiveRecord::Migration[7.1]
  def change
    create_table :varieties do |t|
      t.string :name
      t.references :coffee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
