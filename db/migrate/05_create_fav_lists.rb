class CreateFavLists < ActiveRecord::Migration[5.2]
  def change
    create_table :favs_lists do |t|
      t.integer :user_id
      t.integer :doctor_id 
    end 
  end
end
