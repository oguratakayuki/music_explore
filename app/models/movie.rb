class Movie < ActiveRecord::Base
  belongs_to :artist
  belongs_to :track
  attr_accessor :artist_name
  before_validation :build_artist_relation, if: ->{ artist_name.present? }
  def build_artist_relation
    build_artist(name: artist_name)
  end
end
