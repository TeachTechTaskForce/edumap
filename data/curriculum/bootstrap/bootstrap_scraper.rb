# http://stackoverflow.com/questions/14101985/extract-a-link-with-nokogiri-from-the-text-of-link
require 'nokogiri'
require 'csv'
require 'open-uri'

materials_bootstrap1_page = Nokogiri::HTML(open("http://www.bootstrapworld.org/materials/spring2016/courses/bs1/index.shtml"))
materials_bootstrap2_page = Nokogiri::HTML(open("http://www.bootstrapworld.org/materials/spring2016/courses/bs2/index.shtml"))

def header
  ['url', 'standard_code', 'standard_desc', 'title', 'description', 'length']
end

class Page
  attr_reader :link
  def initialize(link)
    @link = link
    @html = Nokogiri::HTML(open(@link))
  end

  def title
    @html.css(".BootstrapTitle").text
  end

  def standards
    @html.css(".LearningObjectivesListItemContents > p").map(&:text)
  end

  def description
    @html.css("#overviewDescr p").text
  end

  def length
    @html.css(".summary > span.BootstrapHeader").text.split(':').last
  end
end

CSV.open("bootstrap_world.csv", "w") do |csv|
  csv << header

  materials_bootstrap1_page.xpath("//a[starts-with(text(), 'Unit')]/@href").each do |partial_link|
    page = Page.new("http://www.bootstrapworld.org/materials/spring2016/courses/bs1/#{partial_link}")
    page.standards.each do |standard|
      standard_code, standard_desc = standard.split(':')
      csv << [page.link, standard_code, standard_desc, page.title, page.description, page.length]
    end
  end
end
