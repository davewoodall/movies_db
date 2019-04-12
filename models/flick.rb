# frozen_string_literal: true

class Flick
  attr_reader :params, :movie, :rating

  def initialize(params, movie = Movie, rating = Rating)
    @params = params
    @movie = movie.new
    @rating = rating.new
  end

  def index
    movie.index(params)
  end

  def show
    movie_with_ratings(params[:id])
  end

  def by
    case params[:by]
    when 'year' then year
    when 'genre' then genre
    end
  end

  def year
    movie.year(params)
  end

  def genre
    movie.genre(params)
  end

  private

  def movie_with_ratings(id)
    flick = movie.show(id)
    flick[:attributes].push(
      rating: rating.movie_ratings(id)
    )
    flick
  end
end
