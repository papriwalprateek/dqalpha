class Element
  include Mongoid::Document
  field :type, type: String
  field :value, type: String
  field :user, type: String
  embedded_in :wikialgo
end