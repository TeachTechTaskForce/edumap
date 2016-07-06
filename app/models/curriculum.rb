class Curriculum < ActiveRecord::Base
  # has_many :units
  # has_many :lessons, through: :units
  has_many :lessons
end
