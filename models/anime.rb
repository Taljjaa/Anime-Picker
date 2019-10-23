require 'pry'

class Anime < ActiveRecord::Base
    has_many :users_animes
    has_many :users, through: :users_animes

    def self.add(anime_title, username, finished)
        if Anime.find_by(title: anime_title)
            anime_id = Anime.find_by(title: anime_title).id
            user_id = User.find_by(username: username).id
            UsersAnime.find_or_create_by(user_id: user_id, anime_id: anime_id, finished: true)
            puts "Added #{anime_title} to your list"
        else 
            url = create_url(anime_title)
            anime = Anime.create_seedling(url)
            user_id = User.find_by(username: username).id
            UsersAnime.find_or_create_by(user_id: user_id, anime_id: anime.id, finished: finished)
            puts "Added #{anime_title} to your list"
        end
    end

    def self.create_url(anime_title)
        base_url = "https://kitsu.io/api/edge/anime?filter[text]="
        anime_title.gsub!(" ", "%20")
        url = base_url + anime_title
    end

    def self.create_seedling(url)
        response = RestClient.get(url)
        json_data = JSON.parse(response)["data"][0]
        title = json_data["attributes"]["titles"]["en"]
        avg_count = json_data["attributes"]["averageRating"].to_f
        date = json_data["attributes"]["startDate"]
        count = json_data["attributes"]["episodeCount"]
        api_id = json_data["id"].to_i
        Anime.find_or_create_by(title: title, average_rating: avg_count, start_date: date, episode_count: count, api_id: api_id)
    end

    def self.sort_by_ratings
        anime_ratings = []
        Anime.all.each do |anime|
            title = anime.title
            rating = anime.average_rating
            anime_ratings << {title  => rating}
        end
        anime_ratings.sort_by! { |anime| anime.values.max}.reverse
    end

    def self.my_stats(username)
        user = User.find_by(username: username)
        finished_animes = user.users_animes.filter{|anime| anime.finished == true}
        total_animes = user.users_animes
        finished_anime_ids = finished_animes.map do |anime|
            anime.anime_id
        end
        animes = finished_anime_ids.map do |anime_id|
            Anime.find(anime_id)
        end
        episodes = animes.map{|anime| anime.episode_count}
        total_episode_count = episodes.reduce(0) { |sum, num| sum + num }
        puts "You have finished #{finished_animes.length} out of #{total_animes.length} animes" 
        puts
        puts "------------------------------------------------------------------------"
        puts "You have watched #{total_episode_count} total episodes"  
    end

end