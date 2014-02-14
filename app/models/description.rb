class Description
  include Mongoid::Document
  field :source, type: String
  field :content, type: String
  embedded_in :wikialgo
end