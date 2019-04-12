# frozen_string_literal: true

db = DB.connect('./db/movies.db', :movies)

class Movie < Sequel::Model(db)
  def index(params, limit = 50)
    limit = params[:limit] || limit
    Movie.all
         .paginate(page: params[:page], per_page: limit)
         .map { |movie| parse(movie) }
  end

  def show(id)
    query = Movie[id]
    movie = parse(query)
    movie[:relationships].concat query_relationships(query)
    movie[:attributes].concat query_attributes(query)
    movie
  end

  def year(params)
    years = get_movies_by(:releaseDate, params)
    case params[:order]
    when 'desc'
      years.sort { |small, big| big[:attributes][1][:releaseDate] <=> small[:attributes][1][:releaseDate] }
    else
      years.sort_by { |movie| movie[:attributes][1][:releaseDate] }
    end
  end

  def genre(params)
    get_movies_by(:genres, params)
  end

  private

  def get_movies_by(attr, params, limit = 50)
    limit = params[:limit] || limit
    Movie.grep(attr, "%#{params['for'].titlecase}%")
         .map { |movie| parse(movie) }
         .paginate(page: params[:page], per_page: limit)
  end

  def parse(movie)
    {
      attributes: attributes(movie),
      relationships: relationships(movie),
      links: links(movie)
    }
  end

  def attributes(movie)
    [
      { imdbId: movie.imdbId },
      { releaseDate: movie.releaseDate },
      { budget: Number.usd(movie.budget) },
      { title: movie.title }
    ]
  end

  def relationships(movie)
    [
      genres: JSON.parse(movie.genres)
    ]
  end

  def links(movie)
    [
      rel: 'self',
      href: "http://localhost:9292/movies/#{movie.movieId}"
    ]
  end

  def query_attributes(query)
    [
      { description: query.overview },
      { runtime: query.runtime },
      { language: query.language }
    ]
  end

  def query_relationships(query)
    [
      { productionCompanies:
       JSON.parse(query.productionCompanies) }
    ]
  end
end
