require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'csv'
#require 'data_mapper'
#require 'pg'


agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

page = agent.get('https://www.google.com/edu/resources/programs/exploring-computational-thinking/index.html#!ct-materials')

name = page.parser.xpath('//li/div/p').text
description = page.parser.xpath('//li/div/p[1]')
subject = page.parser.xpath('//li/div/p[2]')
age = page.parser.xpath('//li/div/p[3]')
type = page.parser.xpath('//li/div/p[4]')
reference = page.parser.xpath('//li/div/em')


CSV.open("classes.csv", "w", {:col_sep => "|", :quote_char => '\'', :force_quotes => false, :skip_blanks => true}) do |csv|
	csv << ["Core Subject", "Subject", "Suggested Age", "Type", "Titel", "URL", "Description"]
page.parser.xpath('//li').each do |row|
  tarray = []
    row.xpath('div/*').each  do |cell|

    tarray <<  cell.text.strip

  end

 # puts tarray

  csv << tarray


	end

end


=begin

rescue Exception => e
	 #/^(?:,\s*)+$/ skip_lines:
	#puts name
	#puts description
	#puts subject
	#puts age
	#puts type
	#puts reference
#puts (@name, @description, @subject, @age, @type).each
end
CSV.open("classes.csv", "w", {:col_sep => '|'}) do |csv|
  csv << ["name", "description", "subject", "age", "type"]
 # [@name, @description, @subject, @age, @type].each do |row| #


  	#(name, description, subject, age, type).each do |row|
  csv << row if row.compact.empty?


  #end
    #link = cell.to_xml['href'] #attributes
   text = cell.text.strip
end
=end
#puts row



#pp page