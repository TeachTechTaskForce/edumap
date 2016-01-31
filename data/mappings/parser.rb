require 'csv'

CSV.foreach('CSTA.csv') do |result|
  p result[1].split(/[.:]/)
end