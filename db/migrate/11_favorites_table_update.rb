class FavoritesTableUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :rating, :integer 
    add_column :favorites, :comments, :string
  end
end
