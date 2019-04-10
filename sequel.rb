require 'pry'
require 'sequel'
require 'sqlite3'

DB = Sequel.sqlite # memory database, requires sqlite3

DB.create_table :movies do
  primary_key :movieId
  String :imdbId, null: false
  String :title, null: false
  String :overview
  String :productionCompanies
  String :releaseDate
  Fixnum :budget
  Fixnum :revenue
  DateTime :runtime
  String :language
  String :genres
  String :statu
end

# DB = Sequel.connect('sqlite://movies.db') # requires sqlite3

movies = DB[:movies] # Create a dataset

# Populate the table
movies.insert(:imdbId => 'life aquatic', :title => 'life aquatic',)

# Print out the number of records
puts "Movies count: #{movies.count}"

# Print out the average price
# puts "The average price is: #{items.avg(:price)}"
