require_relative '../config/environment'
require 'pry'
require 'colorize'
require "tty-prompt"

$prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)

# def go_back(question, option) 
#     $prompt.select(question, option)
# end

def main_menu
    # $prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
    system "clear"
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
        Anime.get_my_animes($username)
        sleep 3.5
    elsif input == "2"
        system "clear" 
        puts "What anime would you like to add?".colorize(:white)
        anime_title = gets.chomp
        puts "Have you finished this anime".colorize(:white)
        finished = gets.chomp
        if finished == "yes"
            finished = true
        elsif finished == "no"
            finished = false
        else
            puts "Please enter yes or no"
        end
        Anime.add(anime_title, $username, finished)
        sleep 3.5
    elsif input == "3"
        system "clear"
        Anime.get_my_animes($username)
        puts "Press 1 to delete an anime or anything to go back".colorize(:white)
        temp = gets.chomp
        case temp 
        when "1"
            puts "Please enter the anime title you would like to delete".colorize(:white)
            anime_title = gets.chomp
            Anime.seek_and_destroy(anime_title, $username)
            sleep 3.5
        else 
           puts "Going back"
           sleep 0.5
        end
    elsif input == "4"
        system "clear" 
       Anime.sort_by_ratings
       sleep 4
    elsif input == "5"
        system "clear" 
        puts Anime.my_stats($username)
        sleep 3.5
    elsif input == "6"
        puts "Goodbye #{$username}".colorize(:light_magenta)
        return
    else 
        puts "Invalid Input".colorize(:red)
    end
    system "clear"
    main_menu
end 

system "clear"
puts font.write("ANIME PICKER")

puts "Please create a username".colorize(:white)
$username = gets.chomp
system "clear"
main_menu


