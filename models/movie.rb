require_relative '../db/db'

db = DB.connect('./db/movies.db', :movies)

class Movie < Sequel::Model(db)
  def self.details(id)
    movie = Movie[id]
    movie.productionCompanies = JSON.parse(movie.productionCompanies)
    movie.genres = JSON.parse(movie.genres)
    movie
  end
end
