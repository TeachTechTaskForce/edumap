class Code < ActiveRecord::Base
  belongs_to :standard
  has_and_belongs_to_many :lessons
end
