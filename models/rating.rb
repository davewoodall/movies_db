require_relative '../db/db'

db = DB.connect('./db/ratings.db', :ratings)

class Rating < Sequel::Model(db)
  def self.movie_ratings(id)
    Rating.where(movieId: id).avg(:rating)
  end
end
