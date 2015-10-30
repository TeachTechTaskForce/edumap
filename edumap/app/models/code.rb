class Code < ActiveRecord::Base
  has_many :results
  belongs_to :level
end
