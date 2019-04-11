require_relative './movie'
require_relative './rating'

class Flick
  def movie(id)
    {
      movie: Movie.details(id),
      rating: Rating.movie_ratings(id)
    }
  end

  def self.by(params)
    case params[:by]
    when 'year'
      year(params)
    when 'genre'
      genre(params)
    end
  end

  def self.year(params)
    # _limit to page
    Movie.grep(:releaseDate, "%#{params['for']}%").limit(5)
  end

  def self.genre(params)
    # _limit to page
    Movie.grep(:genres, "%#{params['for'].titlecase}%").limit(2)
  end

  def self.all
    Movie.all
  end
end


