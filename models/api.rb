require_relative './movie'
require_relative './rating'

class Flick
  def self.movie(id)
    {
      movie: Movie.details(id),
      rating: Rating.movie_ratings(id)
    }
  end

  def self.all
    movie = Movie[id]
    movie.productionCompanies = JSON.parse(movie.productionCompanies)
    movie.genres = JSON.parse(movie.genres)
    movie
  end
end


