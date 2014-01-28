class Page
  include Mongoid::Document
  field :title, type: String
  field :link, type: String
  field :prank, type: Integer, default: 0
  embedded_in :wikialgo
end