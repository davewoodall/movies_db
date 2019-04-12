# _dw move to config.ru?
require_relative './movie'
require_relative './rating'

class Flick

  def self.movie(movie=Movie)
    movie
  end

  def self.index(params)
    movie.index(params)
  end

  def self.show(id)
    {
      movie: movie.show(id),
      rating: Rating.movie_ratings(id)
    }
  end

  def self.by(params)
    case params[:by]
    when 'year' then year(params)
    when 'genre' then genre(params)
    end
  end

  def self.year(params)
    movie.year(params)
  end

  def self.genre(params)
    movie.genre(params)
  end
end


