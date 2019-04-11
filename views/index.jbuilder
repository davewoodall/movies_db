
json.movies_by params[:by]
json.for params[:for]
json.movies data, :imdbId, :title, :releaseDate, :budget, :genres

# _budget as dollars
# _pagination
# _rating rounded
# _genre parsed
# _add tests
# _refactor
# _json partial for similar content