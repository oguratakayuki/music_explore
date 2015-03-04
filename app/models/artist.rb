class Artist < ActiveRecord::Base
  include LastfmApi
  mount_uploader :image, ArtistImageUploader
end
