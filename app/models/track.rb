class Track < ActiveRecord::Base
  has_many :youtube_playlist_tracks
  has_many :youtube_playlists, through: :youtube_playlist_tracks
end
