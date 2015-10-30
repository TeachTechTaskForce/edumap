class Unit < ActiveRecord::Base
  belongs_to :curriculum
  has_many :lessons
end
