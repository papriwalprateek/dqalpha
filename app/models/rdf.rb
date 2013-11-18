class Rdf
  include Mongoid::Document

  field :q_id, type: Integer
  field :quest_id, type: Integer
  field :tags, type: Array
end