require 'pry'
require 'colorize'

class Anime < ActiveRecord::Base
    has_many :users_animes
    has_many :users, through: :users_animes

    def self.get_my_animes(username) 
        if User.find_by(username: username).animes.length < 1
            puts "No animes found =(".colorize(:red)
        else 
            anime_titles = User.find_by(username: $username).animes.map{|anime| anime.title}
            puts anime_titles 
        end
    end

    def self.add(anime_title, username, finished)
        if Anime.find_by(title: anime_title)
            anime_id = Anime.find_by(title: anime_title).id
            user_id = User.find_by(username: username).id
            UsersAnime.find_or_create_by(user_id: user_id, anime_id: anime_id, finished: true)
            puts "Added #{anime_title} to your list"
        else 
            url = create_url(anime_title)
            anime = Anime.create_seedling(url)
            if !anime 
                puts "Could not find anime #{anime_title}. Please try again".colorize(:red)
                return
            end
            user_id = User.find_by(username: username).id
            UsersAnime.find_or_create_by(user_id: user_id, anime_id: anime.id, finished: finished)
            puts "Added #{anime_title} to your list"
        end
    end

    def self.create_url(anime_title)
        base_url = "https://kitsu.io/api/edge/anime?filter[text]="
        query_anime_title = anime_title.gsub(" ", "%20")
        url = base_url + query_anime_title
    end

    def self.create_seedling(url)
        response = RestClient.get(url)
        json_data = JSON.parse(response)["data"][0]
        if !json_data 
           return false
        end
        title = json_data["attributes"]["titles"]["en"]
        if !title
            title = json_data["attributes"]["titles"]["en_us"]
        end
        avg_count = json_data["attributes"]["averageRating"].to_f
        date = json_data["attributes"]["startDate"]
        count = json_data["attributes"]["episodeCount"]
        api_id = json_data["id"].to_i
        Anime.find_or_create_by(title: title, average_rating: avg_count, start_date: date, episode_count: count, api_id: api_id)
    end

    def self.seek_and_destroy(anime_title, username)
        anime_id = Anime.find_by(title: anime_title).id
        Anime.delete(anime_id)
        user_id = User.find_by(username: username).id
        users_anime_id = UsersAnime.find_by(user_id: user_id, anime_id: anime_id).id
        UsersAnime.delete(users_anime_id)
        puts "Deleted #{anime_title} from your list"
    end

    def self.sort_by_ratings
        anime_ratings = []
        Anime.all.each do |anime|
            title = anime.title
            rating = anime.average_rating
            anime_ratings << {title  => rating}
        end
        anime_ratings = anime_ratings.sort_by { |anime| anime.values.max}.reverse
        anime_ratings.each do |anime|
            anime.each do |name, rating| 
            puts "#{name}: #{rating}"
            end 
        end
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
        puts "------------------------------------------------------------------------"
        puts "You have watched #{total_episode_count} total episodes"  
    end

end