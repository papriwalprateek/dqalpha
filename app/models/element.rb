class Element
  include Mongoid::Document
  field :type, type: String
  field :value, type: String
  field :user_id, type: Integer
  embedded_in :wikialgo
end