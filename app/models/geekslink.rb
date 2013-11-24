class Geekslink
  include Mongoid::Document

  field :link, type: String
  field :htag, type: String
end