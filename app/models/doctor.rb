class Doctor < ActiveRecord::Base
    has_many :favs_lists
    has_many :users, through: :favs_list 
    belongs_to :specialty
    belongs_to :location 
end
