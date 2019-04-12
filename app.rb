# frozen_string_literal: true

get '/movies' do
  flick = Flick.new(params)
  data = if params[:by]
           flick.by
         else
           flick.index
  end

  jbuilder(:'movies/index', {}, data: data)
end

get '/movies/:id' do
  flick = Flick.new(params)

  jbuilder(:'movies/show', {}, data: flick.show)
end
