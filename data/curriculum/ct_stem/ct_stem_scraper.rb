require 'nokogiri'
require 'CSV'

require 'open-uri'
doc = Nokogiri::HTML(open("http://ct-stem.northwestern.edu/assess/lesson-plans/lesson-plans.html"))

CSV.open("edumap/mappings/ct_stem.csv", "wb") do |csv|
  doc.css(".lesson-plan-table td a").each do |node|
    link = "http://http://ct-stem.northwestern.edu#{node['href']}"
    csv << [node.text, link]
  end
end
