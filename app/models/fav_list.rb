class Favs_list < ActiveRecord::Base
    belongs_to :doctors
    belongs_to :users 
end
