class Song
  include Mongoid::Document
  field :audio_sc, type: Array
  field :video_yt, type: Array
  field :lyrics, type: String
  field :title, type: String
  field :lastfm_url, type: String
  field :artist, type: String
  field :img_s, type: String
  field :img_m, type: String
  field :wiki, type: String
  field :wiki_artist, type: String
  field :meaning, type: Array
  field :facts, type: String
end