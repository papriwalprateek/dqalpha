class Q < ActiveRecord::Base
  attr_accessible :title
  belongs_to :quest
  has_many :qmails, :dependent => :destroy
  include PgSearch
  multisearchable :against => [:title]
end
