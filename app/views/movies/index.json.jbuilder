json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :artist_id, :track, :provider, :url
  json.url movie_url(movie, format: :json)
end
