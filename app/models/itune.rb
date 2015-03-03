require 'open-uri'
require 'kconv'
require 'csv'

class Itune < ActiveRecord::Base
  mount_uploader :file, ItuneXmlUploader
  after_save :parse_xml
  def parse_xml
    #records = []
    #tmp_record = nil;
    #file =  open(Itune.last.file.path)
    #xml = Nokogiri::XML(file)
    #data = Hash.from_xml(xml)

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
          Artist.find_or_create_by(name: str.toutf8)
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
