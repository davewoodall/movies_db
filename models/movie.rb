require_relative '../db/db'
require_relative '../helpers/number'


db = DB.connect('./db/movies.db', :movies)

class Movie < Sequel::Model(db)
  def self.details(id)
    movie = Movie[id]
    movie.productionCompanies = JSON.parse(movie.productionCompanies)
    movie.genres = JSON.parse(movie.genres)
    movie
  end

  def self.all()
    Movie.limit(12).map do |m|
      {
        imdbId: m.imdbId,
        title: m.title,
        releaseDate: m.releaseDate,
        budget: Number.usd(m.budget),
        genres: JSON.parse(m.genres),
      }
    end
  end
end
