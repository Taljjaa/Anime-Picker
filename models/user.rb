class User < ActiveRecord::Base
    has_many :users_animes
    has_many :animes, through: :users_animes
end