require 'nokogiri'
require 'csv'
require 'open-uri'
require '../page'

def header
  ['url', 'standard_code', 'standard_desc', 'title', 'description', 'length']
end

class CodeDotOrgPage < Page
  def title
    @html.css(".headercontent h1").text
  end

  def standards
    @html.css(".standards li").map(&:text)
  end

  def description
    @html.css('.content > .together > p:first').text
  end

  def length
    @html.text.match(/Lesson time: (\d* Minutes)/)[1] #[1] is for the regex group
  end
end

CSV.open("cod_dot_org.csv", "w") do |csv|
  csv << header

  ['https://code.org/curriculum/course3/1/Teacher'].each do |link|
    page = CodeDotOrgPage.new(link)
    page.standards.each do |standard|
      standard_code, standard_desc = standard.split('-')
      csv << [page.link, standard_code, standard_desc, page.title, page.description, page.length]
    end
  end
end
