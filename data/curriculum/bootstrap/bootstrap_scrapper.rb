# http://stackoverflow.com/questions/14101985/extract-a-link-with-nokogiri-from-the-text-of-link
require 'nokogiri'
require 'csv'
require 'open-uri'

materials_bootstrap1_page = Nokogiri::HTML(open("http://www.bootstrapworld.org/materials/spring2016/courses/bs1/index.shtml"))
materials_bootstrap2_page = Nokogiri::HTML(open("http://www.bootstrapworld.org/materials/spring2016/courses/bs2/index.shtml"))

File.open("bootstrapworld.txt", "w") do |file|
  materials_bootstrap1_page.xpath("//a[starts-with(text(), 'Unit')]/@href").each do |partial_link|
    current_unit_page = Nokogiri::HTML(open("http://www.bootstrapworld.org/materials/spring2016/courses/bs1/#{partial_link}"))
    current_page_title = current_unit_page.css(".BootstrapTitle").text
    current_page_standards = current_unit_page.css(".LearningObjectivesListItemContents p span").map(&:text)
    file.puts(current_page_title, current_page_standards)
    
  end
  file.close

end

