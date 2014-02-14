class Wikialgo
  include Mongoid::Document
  embeds_many :pages
  embeds_many :descriptions
  field :title, type: String
  field :category, type: String
end