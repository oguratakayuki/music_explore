class YoutubePlaylist < ActiveRecord::Base
  has_many :youtube_playlist_movies
  has_many :movies, through: :youtube_playlist_movies
  before_validation :set_filename, if:  -> { file_changed? }
  before_save :parse_playlist
  mount_uploader :file, YoutubePlaylistUploader
  validates_presence_of :title
  accepts_nested_attributes_for :movies

  def set_filename
    self.title = file.file.try(:filename)
  end

  def parse_playlist
    YoutubePlaylist.transaction do
      html = Nokogiri::HTML(File.read(file.file.to_file))
      debugger
      html.css('tr.pl-video').each do |tr|
        title = tr['data-title']
        video_id = tr['data-video-id']
        provider = 'youtube'
        url = Youtube.url_for(video_id: video_id)
        movies.build(title: title, provider: provider, url: url)
      end
    end
  end
end
