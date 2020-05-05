class AddColsToFavsList < ActiveRecord::Migration[5.2]
  def change
    add_column :favs_lists, :rating, :integer 
    add_column :favs_lists, :comments, :string
  end
end
