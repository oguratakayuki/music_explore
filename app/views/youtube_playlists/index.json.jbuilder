json.array!(@youtube_playlists) do |youtube_playlist|
  json.extract! youtube_playlist, :id
  json.url youtube_playlist_url(youtube_playlist, format: :json)
end
