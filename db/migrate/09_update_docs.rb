class UpdateDocs < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :gender, :string
  end
end
