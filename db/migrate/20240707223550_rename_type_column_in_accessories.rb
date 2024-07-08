class RenameTypeColumnInAccessories < ActiveRecord::Migration[7.1]
  def change
    rename_column :accessories, :type, :accessory_type
  end
end
