require 'active_support'
require 'open-uri'

module LastfmApi
  extend ActiveSupport::Concern
  included do
    attr_accessor :lastfm
    def lastfm
      api_key = Settings.lastfm[:api_key]
      api_secret = Settings.lastfm[:api_secret]
      @lastfm = Lastfm.new(api_key, api_secret)
    end
    def find_image
      if mbid && image.url.nil?
        api_result = self.search_from_api_by_mbid(mbid)
        self.remote_image_url = api_result["image"].find{|t| t["size"] == "medium"}["content"]
        save
      end
    end
    def search_from_api_by_mbid(mbid)
      lastfm.artist.get_info(mbid: mbid)
    end

    def search_from_api_by_name(name)
      artists = lastfm.artist.search(artist: name)
      artists["results"]["artistmatches"]["artist"].find{|t| URI.unescape(t["name"]).downcase == name }
    end
  end
  module ClassMethods
    def find_or_create_by(param)
      name = param.key?(:name) ? URI.unescape(param[:name]).downcase : nil
      mbid = param.key?(:mbid) ? param[:mbid] : nil
      if name
        ret ||= find_by_name(name)
      else
        ret ||= find_by_mbid(mbid)
      end
      return ret if ret.present?
      create_by_api(:lastfm)
      artist
    end
    def create_by_api
      artist = Artist.new(name: name, mbid: mbid)
      request_hash = name ? {artist: name} : {mbid: mbid}
      api_result = artist.search_from_api(request_hash)
      if api_result.present?
        artist.name = URI.unescape(api_result["name"]).downcase
        artist.mbid = api_result['mbid']
        #artist.remote_image_url = api_result["image"].find{|t| t["size"] == "medium"}["content"]
      end
      artist.save
    end
  end
end
