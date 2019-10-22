require_relative '../config/environment'

puts "----------WELCOME TO ANIME PICKER!----------"



puts "Please create a username"
username = gets.chomp
User.find_or_create_by(username: username)
puts "Welcome, #{username}"
