class Page
  include Mongoid::Document
  field :title, type: String
  field :link, type: String
  embedded_in :wikialgo
end