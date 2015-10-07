class YoutubePlaylist < ActiveRecord::Base
  has_many :youtube_playlist_tracks
  has_many :tracks, through: :youtube_playlist_tracks
  before_save :set_filename
  after_save :parse_playlist
  mount_uploader :file, YoutubePlaylistUploader
  def set_filename
    title = file.name
  end
  def parse_playlist
    debugger
  end
end
