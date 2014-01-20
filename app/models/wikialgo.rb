class Wikialgo
  include Mongoid::Document
  embeds_many :elements
  embeds_many :pages
  field :link, type: String
  field :htag, type: String
end