require_relative '../db/db'
require_relative '../helpers/number'
require 'will_paginate/array'
require 'will_paginate/sequel'


db = DB.connect('./db/movies.db', :movies)

class Movie < Sequel::Model(db)

  def self.show(id)
    # _dw show
    movie = Movie[id]
    movie.productionCompanies = JSON.parse(movie.productionCompanies)
    movie.genres = JSON.parse(movie.genres)
    movie
  end

  def self.index(params, limit=50)
    limit = params[:limit] || limit
    Movie.all
    .paginate(page: params[:page], per_page: limit)
    .map  { |movie| parse(movie) }
  end

  def self.year(params)
    get_movies_by(:releaseDate, params)
  end

  def self.genre(params)
    get_movies_by(:genres, params)
  end

  def self.get_movies_by(attr, params, limit=50)
    limit = params[:limit] || limit
    Movie.grep(attr, "%#{params['for'].titlecase}%")
      .map { |movie| parse(movie) }
      .paginate(page: params[:page], per_page: limit)
  end

  def self.parse(movie)
    {
      imdbId: movie.imdbId,
      title: movie.title,
      releaseDate: movie.releaseDate,
      budget: Number.usd(movie.budget),
      genres: JSON.parse(movie.genres),
    }
  end
end
