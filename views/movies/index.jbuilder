if params[:by]
  json.filter do
    json.by params[:by] || ''
    json.for params[:for] || ''
  end
end

json.movies data


