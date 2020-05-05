class AddColumnsToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :state, :string 
    add_column :locations, :zip_code, :integer
  end
end
