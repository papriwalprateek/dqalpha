class Geekslink
  include Mongoid::Document
  include Mongoid::Search

  field :link, type: String
  field :htag, type: String
  search_in :htag
end