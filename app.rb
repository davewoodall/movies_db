require "sinatra"
require './models/api'
require 'sinatra/jbuilder'

get '/movies/:id' do
  jbuilder(:index, {}, { flick: Flick.movie(params[:id])})
end


