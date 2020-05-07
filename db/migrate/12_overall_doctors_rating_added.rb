class OverallDoctorsRatingAdded < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :rate, :integer 
  end
end
