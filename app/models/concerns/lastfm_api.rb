require 'active_support'
require 'open-uri'

module LastfmApi
  extend ActiveSupport::Concern
  included do
    attr_accessor :lastfm
    #after_initialize :initialize_lastfm
    #def initialize_lastfm
    @lastfm = Lastfm.new(@api_key, @api_secret)
    @token = @lastfm.auth.get_token
    #end
    #
  end
  module ClassMethods
    def new_from_lastfm(hash)
      if hash.key?(:name)
        name = URI.unescape(hash[:name]).downcase
        artists = @lastfm.artist.search(artist: hash[:name])
        temp = artists["results"]["artistmatches"]["artist"].find{|t| URI.unescape(t["name"]).downcase == name}
        #image_url = temp["image"].find{|t| t["size"] == "medium"}["content"]
        artist = Artist.new
        artist.name = name
        artist.remote_image_url = temp["image"].find{|t| t["size"] == "medium"}["content"]
        #tempfile = open(image_url)
        #artist.image.store! tempfile
        artist.mb_id = temp["mbid"]
        artist.save
        #uploader = ImageUploader.new
        #uploader.store! tempfile
      end
    end
  end






  def parse_artist_info_hash(artist_name, h_obj,parent_hash_key='',block_logic)
    h_obj.each { |key,value|
      #valeがhashであるということは子要素があるということで、再帰処理で分解する
      if  value.instance_of?(Hash) == false
        #artist,image以下は配列になっていて
        #しかもkeyにhashが入っている
        if key == 'artist'
          parent_hash_key +=  '/' +  key
          value.each do |key,value|
            #何故かkeyにhashデータが入ってしまう
            if  key.has_key?('name')
              #nameにartist名が入ってくる
              #artist名でヒットしたartistの一覧がhashでくる
              #のでfeat.系を除外するため完全一致条件追加
              temp_artist_name = key['name'].downcase
              if temp_artist_name == artist_name
                parse_artist_info_hash(artist_name, key,parent_hash_key,block_logic)
              end
            else
              parse_artist_info_hash(artist_name, key,parent_hash_key,block_logic)
            end
          end
        elsif key == 'image'
          parent_hash_key +=  '/' +  key
          value.each do |key,value|
            #何故かkeyにhashデータが入ってしまう
            #p "image size: " + key['size']
            #p "image path: " + key['#text']
            block_logic.call("image_" + key['size'],key['#text'])
          end
        else
          #puts "parent: #{parent_hash_key},  key: #{key},   value: #{value}\n"
          block_logic.call(key,value)
        end
      else
        parent_hash_key +=  '/' +  key
        parse_artist_info_hash(artist_name, value,parent_hash_key,block_logic)
      end
    }
  end

end
