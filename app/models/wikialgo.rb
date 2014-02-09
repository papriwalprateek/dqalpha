class Wikialgo
  include Mongoid::Document
  embeds_many :pages
  field :title, type: String
  field :category, type: String

end