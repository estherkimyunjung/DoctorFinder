class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :name 
      t.string :location_id 
      t.string :phone_number 
      t.integer :specialty_id 
    end 
  end
end
