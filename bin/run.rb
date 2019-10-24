require_relative '../config/environment'
require 'pry'
require 'colorize'
require "tty-prompt"

$prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)

def main_menu
    # $prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))

    User.find_or_create_by(username: $username)
    puts "What would you like to do?"
    puts "1. See my list of my animes".colorize(:white)
    puts "2. Add an anime to my list".colorize(:white)
    puts "3. Delete an anime from my list".colorize(:white)
    puts "4. List all anime by anime rating".colorize(:white)
    puts "5. See my stats".colorize(:white)
    puts "6. Exit =(".colorize(:white)
    input = gets.chomp

    if input == "1"
        system "clear" 
        if User.find_by(username: $username).animes.length < 1
            puts "No animes found =(".colorize(:red)
        else 
            anime_titles = User.find_by(username: $username).animes.map{|anime| anime.title}
            puts anime_titles 
        end
        
    elsif input == "2"
        system "clear" 
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
        puts "input was 3"
    elsif input == "4"
        system "clear" 
       Anime.sort_by_ratings
    elsif input == "5"
        system "clear" 
        puts
        Anime.my_stats($username)
    elsif input == "6"
        puts "Goodbye #{$username}".colorize(:light_magenta)
        return
    else 
        puts "Invalid Input".colorize(:red)
    end
    sleep 4
    system "clear"
    main_menu
end 

system "clear"
puts font.write("ANIME PICKER")

puts "Please create a username"
$username = gets.chomp
puts "Welcome, #{$username}"
system "clear"
main_menu


