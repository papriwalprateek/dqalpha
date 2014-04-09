class Song
  include Mongoid::Document
  field :audio, type: Array
  field :lyrics, type: String
  field :title, type: String
  field :artist, type: String
  field :official_video, type: String
end