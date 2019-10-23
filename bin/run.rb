require_relative '../config/environment'
require 'pry'

puts "----------WELCOME TO ANIME PICKER!----------"

puts "Please create a username"
$username = gets.chomp

def main_menu
    User.find_or_create_by(username: $username)
    puts "Welcome, #{$username}"
    puts "What would you like to do"
    puts "1. See my list of my animes"
    puts "2. Highest rated anime"
    puts "3. Add an anime to my list"
    puts "4. See my stats"
    puts "5. Exit =("
    input = gets.chomp

    if input == "1" 
        if User.find_by(username: $username).animes.length < 1
            puts "No animes found =("
            puts "----------------------------------"
        else 
            puts User.find_by(username: $username).animes
        end
    end

    if input == "2"
        puts "potato 2"
        Anime.sort_by_ratings
    end

    if input == "3"
        puts "What anime would you like to add?"
        anime_title = gets.chomp
        Anime.find_or_create_by(anime_title)
    end

    if input == "4"
        puts "pasta 4"
    end

    if input == "5"
        puts "Goodbye #{$username}"
        return
    end
    main_menu
end

main_menu


