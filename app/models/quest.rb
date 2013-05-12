class Quest < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :involvements, :dependent => :destroy
  has_many :qs, :dependent => :destroy
  has_many :links
  has_many :users, :through => :involvements, :uniq => true 
end
