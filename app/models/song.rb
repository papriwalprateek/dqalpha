class Song
  include Mongoid::Document
  field :audio_sc, type: Array
  field :video_yt, type: Array
  field :lyrics, type: String
  field :title, type: String
  field :lang, type: String #hindi english
  field :album, type: String
  field :lastfm_url, type: String
  field :artists, type: Array
  field :img_s, type: String
  field :img_m, type: String
  field :wiki, type: String
  field :wiki_artist, type: String
  field :meaning, type: Array
  field :facts, type: String
#  field :usa_today_url, type: String
  def usa_today_url
    if artist
     require 'open-uri'
    return "http://www.usatoday.com/search/"+URI.encode(artist)+'/'
    end
  end
  
  def india_today_url
    if album
    return 'http://indiatoday.intoday.in/advanced_search.jsp?option=com_search&searchword=' + album.gsub(' ','+')
    end
  end
  
end