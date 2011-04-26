class School < ActiveRecord::Base
  has_many :students
  attr_accessible :school_name
  
  validates_presence_of :school_name
  validates_uniqueness_of :school_name
  
end
