require 'nokogiri'
require 'CSV'

require 'open-uri'
doc = Nokogiri::HTML(open("http://ct-stem.northwestern.edu/assess/lesson-plans/lesson-plans.html"))

CSV.open("ct_stem.csv", "wb") do |csv|
  links = []
  doc.css(".lesson-plan-table td a").each do |node|
    links << "http://http://ct-stem.northwestern.edu#{node['href']}"
  end
  n = 0
  doc.css(".lesson-plan-table tr").each do |node|
    unless node.css("p")[1].text == "NGSS Practices"
      standards = node.css("p")[1].text
      name = node.css("a").text
      description = "Students #{node.css("td p").last.text}"
      csv << [name, standards, description, links[n]]
      n += 1
    end
  end
end
