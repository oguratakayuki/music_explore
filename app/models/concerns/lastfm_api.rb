require 'active_support'
require 'open-uri'

module LastfmApi
  extend ActiveSupport::Concern
  included do
    attr_accessor :lastfm
    @api_key = Settings.lastfm[:api_key]
    @api_secret = Settings.lastfm[:api_secret]
    @lastfm = Lastfm.new(@api_key, @api_secret)
    @token = @lastfm.auth.get_token
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
      if ret.present?
        return ret
      end
      artist = Artist.new(name: name, mbid: mbid)
      request_hash = name ? {artist: name} : {mbid: mbid}
      api_result = search_from_api(request_hash)
      if api_result.present?
        artist.name = URI.unescape(api_result["name"]).downcase
        artist.mbid = api_result['mbid']
        #artist.remote_image_url = api_result["image"].find{|t| t["size"] == "medium"}["content"]
      end
      artist.save
      artist
    end
    def search_from_api(request_hash)
      artists = @lastfm.artist.search(request_hash)
      temp = artists["results"]["artistmatches"]["artist"].find do |t|
        if request_hash.key?(:artist)
          URI.unescape(t["name"]).downcase == request_hash[:artist]
        else
          t["mbid"] == request_hash[:mbid]
        end
      end
      temp
    end
  end
end
