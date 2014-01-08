class Wikialgo
  include Mongoid::Document
  embeds_many :elements
  field :link, type: String
  field :htag, type: String
end