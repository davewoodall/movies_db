require "sinatra"
require './models/flick'
require 'sinatra/jbuilder'

get '/movies' do
  data = if params[:by]
    Flick.by(params)
  else
    Flick.index(params)
  end
  jbuilder(:'movies/index', {}, data: data)
end

get '/movies/:id' do # _pageination
  jbuilder(:'movies/show', {}, { flick: Flick.show(params[:id])})
end


