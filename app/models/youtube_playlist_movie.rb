class YoutubePlaylistMovie < ActiveRecord::Base
  belongs_to :youtube_play_list
  belongs_to :movie
end
