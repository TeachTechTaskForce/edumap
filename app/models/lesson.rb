class Lesson < ActiveRecord::Base

  belongs_to :module
  has_many :results

end
