class Location < ActiveRecord::Base
    has_many :doctors
    has_many :specialties, through: :doctors
end
