# frozen_string_literal: true

db = DB.connect('./db/ratings.db', :ratings)

class Rating < Sequel::Model(db)
  def movie_ratings(id)
    rating = Rating.where(movieId: id).avg(:rating)
    rating&.round(2)
  end
end
