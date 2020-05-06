class Doctor < ActiveRecord::Base
    has_many :favorites
    has_many :users, through: :favorites
    belongs_to :specialty
    belongs_to :location 
end
