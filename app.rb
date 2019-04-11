require "sinatra"
require './models/api'
require 'sinatra/jbuilder'

get '/movies' do
  data = if params[:by]
    Flick.by(params)
  else
    Flick.all
  end
  jbuilder(:index, {}, data: data)
end

get '/movies/:id' do # _pageination
  jbuilder(:show, {}, { flick: Flick.new.movie(params[:id])})
end


