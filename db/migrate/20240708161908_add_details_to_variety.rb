class AddDetailsToVariety < ActiveRecord::Migration[7.1]
  def change
    add_column :varieties, :species, :string
    add_column :varieties, :url, :string
    add_column :varieties, :description, :text
    add_column :varieties, :subname, :string
  end
end
