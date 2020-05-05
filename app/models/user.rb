class User < ActiveRecord::Base
    has_many :favs_list 
    has_many :doctors, through: :favs_list 
end
