class Wikialgo
  include Mongoid::Document
  embeds_many :pages
  embeds_many :descriptions
  embeds_many :elements
  field :title, type: String
  field :category, type: String
end