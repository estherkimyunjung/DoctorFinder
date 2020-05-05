class AddColsToLocationCity < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :city, :string 
  end
end
