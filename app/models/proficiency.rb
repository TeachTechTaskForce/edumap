class Proficiency < ActiveRecord::Base
  belongs_to :standard
  has_many :levels
end
