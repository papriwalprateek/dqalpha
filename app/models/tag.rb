class Tag
  include Mongoid::Document

  field :qmail_id, type: Integer
  field :name, type: String
end
