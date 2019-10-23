require 'pry'

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
        else 
            url = create_url(anime_title)
        end
    end

    def self.create_url(anime_title)
        base_url = "https://kitsu.io/api/edge/anime?filter[text]="
        anime = anime_title.sub!(" ", "%20")
        binding.pry
        url = base_url + anime
    end
end