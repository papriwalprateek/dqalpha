class Song
  include Mongoid::Document
  field :audio, type: Array
  field :video, type: Array
  field :lyrics, type: String
  field :title, type: String
  field :artist, type: String
end