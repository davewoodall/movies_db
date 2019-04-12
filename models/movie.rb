require_relative '../db/db'
require_relative '../helpers/number'
require 'will_paginate/array'
require 'will_paginate/sequel'


db = DB.connect('./db/movies.db', :movies)

class Movie < Sequel::Model(db)

  def self.show(id)
    # _dw show
    query = Movie[id]
    movie = parse(query)
    movie[:relationships].push(
      { productionCompanies:
        JSON.parse(query.productionCompanies)
      })
    movie[:attributes].concat [
      {description: query.overview},
      {runtime: query.runtime},
      {language: query.language}
    ]
    movie

  end

  def self.index(params, limit=50)
    limit = params[:limit] || limit
    Movie.all
    .paginate(page: params[:page], per_page: limit)
    .map  { |movie| parse(movie) }
  end

  def self.year(params)
    years = get_movies_by(:releaseDate, params)
    case params[:order]
    when 'desc'
      years.sort { |small, big| big[:releaseDate] <=> small[:releaseDate]}
    else
      years.sort { |small, big| small[:releaseDate] <=> big[:releaseDate]}
    end
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
      attributes: [
      {imdbId: movie.imdbId},
      {title: movie.title},
      {releaseDate: movie.releaseDate},
      {budget: Number.usd(movie.budget)},
      ],
      relationships: [
        genres: JSON.parse(movie.genres)
      ],
      links: [
        rel: "self",
        href: "http://localhost:9292/movies/#{movie.movieId}"
      ]
    }
  end
end
