# frozen_string_literal: true

RSpec.describe 'Movies', type: :request do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'get /movies' do
    get '/movies'
    expect(last_response).to be_ok
    expect(movie_from_list_title(last_response)).to eq('Judgment Night')
  end

  it 'get /movies/:id' do
    get '/movies/2'
    expect(last_response).to be_ok
    expect(movie(last_response)[3]['title']).to eq('Ariel')
    expect(movie(last_response)[4]['description']).to include('Taisto Kasurinen')
    expect(movie(last_response)[-1]['rating']).to eq(3.4)
  end

  it 'get /movies by year' do
    get '/movies?by=year&for=1999&limit=4'
    expect(last_response).to be_ok
    expect(movie_from_list_title(last_response)).to eq('American Beauty')
  end

  it 'get /movies by genre' do
    get '/movies?by=genre&for=drama&limit=4'
    expect(last_response).to be_ok
    expect(movie_from_list_title(last_response)).to eq('American Beauty')
  end
end
