class Lesson < ActiveRecord::Base
  # belongs_to :unit
  belongs_to :curriculum
  has_many :results
  has_many :codes, through: :results
end
