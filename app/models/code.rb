class Code < ActiveRecord::Base
  has_many :results
  # belongs_to :level
  belongs_to :standard
  has_many :lessons, through: :results
end
