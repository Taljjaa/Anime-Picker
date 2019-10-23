require_relative '../config/environment'

puts "----------WELCOME TO ANIME PICKER!----------"

def main_menu
    puts "Please create a username"
    username = gets.chomp
    User.find_or_create_by(username: username)
    puts "Welcome, #{username}"
    puts "What would you like to do"
    puts "1. See my list of my animes"
    puts "2. Highest rated anime"
    puts "3. Add an anime to my list"
    puts "4. See my stats"
    puts "5. Exit =("
    input = gets.chomp
    main_menu
end


