require 'open-uri'
require 'kconv'
require 'csv'

class Itune < ActiveRecord::Base
  mount_uploader :file, ItuneXmlUploader
  after_save 'delay.parse_xml'
  def parse_xml
    open(file.path, 'r').each_line do |line|
      line.strip!
      line =~ %r!<string>(.*)</string>!
      next unless $1
      str = $1
      case line
        when %r!^<key>Name</key>!
          #tmp_record = Mp3.new
          #tmp_record.name = str.toutf8
        when %r!^<key>Artist</key>!
          #tmp_record.artist = str.toutf8
          Artist.new_from_lastfm(name: str.toutf8)
        when %r!^<key>Album</key>!
          #tmp_record.album = str.toutf8
        when %r!^<key>Location</key>!
          #tmp_record.location = URI.decode(str.sub('file://localhost/C:/Users/ogura/Music/iTunes/iTunes%20Music/','')).toutf8
          #records << tmp_record
      end
    end
    #CSV.open("public/data/output.csv", "a") do |csv|
    #  records.each do |r|
    #    unless test(?e, r.location)
    #      csv << [r.artist, r.album, r.name, r.location]
    #    end
    #  end
    #end


  end

end
