class Favs_list < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :user
end
