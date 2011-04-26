class Instructor < ActiveRecord::Base
  belongs_to :user
  has_many :students
  has_many :payments
  has_many :lessons
end
