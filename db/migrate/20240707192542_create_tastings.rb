class CreateTastings < ActiveRecord::Migration[7.1]
  def change
    create_table :tastings do |t|
      t.references :extraction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :tasting_type
      t.integer :rating
      t.text :comment
      t.integer :fragrance
      t.integer :acidity
      t.integer :flavor
      t.integer :body
      t.integer :aftertaste
      t.integer :balance

      t.timestamps
    end
  end
end
