class Page
  include Mongoid::Document
  field :title, type: String
  field :link, type: String
  field :prank, type: Integer, default: 0
  field :img_url, type: String
  embedded_in :wikialgo
end