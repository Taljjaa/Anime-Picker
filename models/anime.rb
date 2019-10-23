class Anime < ActiveRecord::Base
    has_many :users_animes
    has_many :users, through: :users_animes

    def self.sort_by_ratings
        # ratings = self.all.map do |anime|
        #     anime.average_rating
        # end
        # puts ratings

    end

    def self.find_or_create_by(anime_title)
        if self.find_by(title: anime_title)
           puts "Found it!"
        end
    end

    def create_url(anime_title)
        anime_title.split(" ")
    end
end