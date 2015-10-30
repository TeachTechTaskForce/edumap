class Curriculum < ActiveRecord::Base
  has_many :units
  has_many :lessons, through: :units
end
