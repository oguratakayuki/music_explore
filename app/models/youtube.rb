class Youtube
  def self.url_for(option={})
    if video_id = option.delete(:video_id)
      "https://www.youtube.com/watch?v=#{video_id}"
    end
  end
end
