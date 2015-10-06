class YoutubePlaylist < ActiveRecord::Base
  has_many :youtube_playlist_tracks
  has_many :tracks, through: :youtube_playlist_tracks
end
