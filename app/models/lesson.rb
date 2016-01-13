class Lesson < ActiveRecord::Base
  # belongs_to :unit
  belongs_to :curriculum
  has_and_belongs_to_many :codes
  has_and_belongs_to_many :levels

end
