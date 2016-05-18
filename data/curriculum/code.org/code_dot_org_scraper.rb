require_relative '../page'

STANDARD_MAPS = {
  "ISTE Standards (formerly NETS)" => "ISTE",
  "CSTA K-12 Computer Science Standards" => "CSTA",
  "NGSS Science and Engineering Practices" => "NGSS",
  "Common Core Mathematical Practices" => "CC Math Practice",
  "Common Core Math Standards" => "CC Math",
  "Common Core Language Arts Standards" => "CC ELA"
}

def header
  ['url', 'standard_code', 'standard_desc', 'title', 'description', 'length']
end

class CodeDotOrgPage < Page
  def title
    @html.css(".headercontent h1").text
  end

  def standards
    @html.css(".standards li")
  end

  def description
    @html.css('.content > .together > p:first').text
  end

  def length
    @html.text.match(/Lesson time: (\d* Minutes)/)[1] #[1] is for the regex group
  end
end

CSV.open(File.join(File.dirname(__FILE__), "code_dot_org.csv"), "w") do |csv|
  csv << header
  ['https://code.org/curriculum/course3/1/Teacher'].each do |link|
    page = CodeDotOrgPage.new(link)
    page.standards.each do |standard|
      s = standard.text.split

      # We want to get the header row with the standard, as that has the standards category
      standard_code = "#{STANDARD_MAPS[standard.parent.previous_element.text]}-#{s.shift}"

      # Some are of form code description, others are code - description
      s.shift if s.first == '-'
      standard_desc = s.join ' ' 

      csv << [page.link, standard_code, standard_desc, page.title, page.description, page.length]
    end
  end
end
