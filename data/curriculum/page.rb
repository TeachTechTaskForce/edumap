# http://stackoverflow.com/questions/14101985/extract-a-link-with-nokogiri-from-the-text-of-link
require 'nokogiri'
require 'csv'
require 'open-uri'

class Page
  attr_reader :link
  def initialize(link)
    @link = link
    @html = Nokogiri::HTML(open(@link))
  end

  def title
  end

  def standards
  end

  def description
  end

  def length
  end
end

