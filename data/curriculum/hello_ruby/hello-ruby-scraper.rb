require 'nokogiri'
require 'CSV'

require 'open-uri'
doc = Nokogiri::HTML(open("http://ct-stem.northwestern.edu/assess/lesson-plans/lesson-plans.html"))

CSV.open("hello-ruby.csv", "wb") do |csv|
  csv << [name, time, description, link, plugged/unplugged]
  csv << ["My First Computer", "45-60 min", "My First Computer exercise is an introduction to the amazing machine that is the computer. Few things are as exciting as computers. And now kids will get to design their very own one.", "http://blog.helloruby.com/post/131553874873/for-educators-lesson-plan-for-my-first-computer", "unplugged"]
  csv << ["Who Am I?", "30 min", "Who am I is an exercise where you get to meet Ruby’s friends and learn deduction skills, self-expression and self-awareness.", "http://blog.helloruby.com/post/131553869403/for-educators-lesson-plan-for-who-am-i-exercise", "unplugged"]
  csv << ["Universal Remote Control", "45-60 min", "Universal Remote Control is an exercise where children get to practice building a remote and giving commands. In the future, more and more things will be programmable. Imagine if everything had a computer inside and you’d have the universal remote.", "http://blog.helloruby.com/post/131553872243/for-educators-lesson-plan-for-universal-remote", "unplugged"]
end
