class Geekslink
  include Mongoid::Document
#  include Mongoid::Search
  #include Mongoid::FullTextSearch


#  fulltext_search_in :htag

  field :link, type: String
  field :htag, type: String
#  search_in :htag
end