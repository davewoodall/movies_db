require "sinatra"
require './models/flick'
require 'sinatra/jbuilder'

get '/movies' do
  data = if params[:by]
    Flick.by(params)
  else
    Flick.all
  end
  jbuilder(:'movies/index', {}, data: data)
end

get '/' do
  jbuilder(:'movies/index', {}, data: Flick.all)
end

get '/movies/:id' do # _pageination
  jbuilder(:'movies/show', {}, { flick: Flick.new.movie(params[:id])})
end


