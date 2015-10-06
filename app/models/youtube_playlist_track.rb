class YoutubePlaylistTrack < ActiveRecord::Base
  belongs_to :youtube_play_list
  belongs_to :track
end
