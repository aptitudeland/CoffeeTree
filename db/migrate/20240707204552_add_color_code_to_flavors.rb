class AddColorCodeToFlavors < ActiveRecord::Migration[7.1]
  def change
    add_column :flavors, :color_code, :string
  end
end
