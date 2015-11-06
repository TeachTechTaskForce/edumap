class Lesson < ActiveRecord::Base

  belongs_to :unit
  has_many :results

end
