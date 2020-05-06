class User < ActiveRecord::Base
    has_many :favorites
    has_many :doctors, through: :favorites
end

