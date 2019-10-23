require_relative '../config/environment'
require 'pry'
require 'colorize'

puts "----------WELCOME TO ANIME PICKER!----------"

puts "Please create a username"
$username = gets.chomp
puts "Welcome, #{$username}"

def main_menu
    User.find_or_create_by(username: $username)
    puts "What would you like to do?"
    puts "1. See my list of my animes"
    puts "2. Add an anime to my list"
    puts "3. List all anime by anime rating"
    puts "4. See my stats"
    puts "5. Exit =("
    input = gets.chomp

    if input == "1" 
        if User.find_by(username: $username).animes.length < 1
            puts "No animes found =("
            puts "----------------------------------"
        else 
            anime_titles = User.find_by(username: $username).animes.map{|anime| anime.title}
            puts anime_titles 
        end
    elsif input == "2"
        puts "What anime would you like to add?"
        anime_title = gets.chomp
        puts "Have you finished this anime"
        finished = gets.chomp
        if finished == "yes"
            finished = true
        elsif finished == "no"
            finished = false
        else
            puts "Please enter yes or no"
        end
        Anime.add(anime_title, $username, finished)
    elsif input == "3"
        puts Anime.sort_by_ratings
    elsif input == "4"
        Anime.my_stats($username)
    elsif input == "5"
        puts "Goodbye #{$username}"
        return
    else 
        puts "Invalid Input".colorize(:red)
    end
    main_menu
end 

main_menu


